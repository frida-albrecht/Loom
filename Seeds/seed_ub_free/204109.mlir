module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<10xi8>}> : () -> tensor<10xi8>
    %1 = "tosa.const"() <{values = dense<5.663000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<10xi8>) -> tensor<1xi8>
    %3 = tosa.sigmoid %1 : (tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %2 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %3 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


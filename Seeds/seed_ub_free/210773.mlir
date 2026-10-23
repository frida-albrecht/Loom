module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.426400e+02> : tensor<4x3xf32>}> : () -> tensor<4x3xf32>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<9x7x10xi8>}> : () -> tensor<9x7x10xi8>
    %2 = "tosa.const"() <{values = dense<20> : tensor<9x7x10xi8>}> : () -> tensor<9x7x10xi8>
    %3 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<4x3xf32>) -> tensor<1x3xf32>
    %4 = tosa.bitwise_and %1, %2 : (tensor<9x7x10xi8>, tensor<9x7x10xi8>) -> tensor<9x7x10xi8>
    %5 = tosa.log %3 : (tensor<1x3xf32>) -> tensor<1x3xf32>
    %cast = tensor.cast %4 : tensor<9x7x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<1x3xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


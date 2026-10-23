module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<10x6xi8>}> : () -> tensor<10x6xi8>
    %1 = "tosa.const"() <{values = dense<-1.149700e+02> : tensor<2x1xf32>}> : () -> tensor<2x1xf32>
    %2 = tosa.bitwise_not %0 : (tensor<10x6xi8>) -> tensor<10x6xi8>
    %3 = tosa.tanh %1 : (tensor<2x1xf32>) -> tensor<2x1xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<2x1xf32>) -> tensor<2x1xf32>
    %cast = tensor.cast %2 : tensor<10x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<2x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


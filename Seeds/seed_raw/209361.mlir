module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<2x10x4xi64>}> : () -> tensor<2x10x4xi64>
    %1 = "tosa.const"() <{values = dense<-5.719000e+01> : tensor<4x1x1x6xf32>}> : () -> tensor<4x1x1x6xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<2x10x4xi64>) -> tensor<1x10x4xi64>
    %3 = tosa.ceil %1 : (tensor<4x1x1x6xf32>) -> tensor<4x1x1x6xf32>
    %4 = tosa.floor %3 : (tensor<4x1x1x6xf32>) -> tensor<4x1x1x6xf32>
    %5 = tosa.identity %4 : (tensor<4x1x1x6xf32>) -> tensor<4x1x1x6xf32>
    %6 = tosa.bitwise_xor %2, %2 : (tensor<1x10x4xi64>, tensor<1x10x4xi64>) -> tensor<1x10x4xi64>
    %cast = tensor.cast %5 : tensor<4x1x1x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<1x10x4xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


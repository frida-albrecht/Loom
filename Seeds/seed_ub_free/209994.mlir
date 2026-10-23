module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.123200e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<6.518000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = "tosa.const"() <{values = dense<-160> : tensor<6xi64>}> : () -> tensor<6xi64>
    %3 = tosa.maximum %0, %1 : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %4 = tosa.exp %3 : (tensor<4xf32>) -> tensor<4xf32>
    %5 = tosa.clz %2 : (tensor<6xi64>) -> tensor<6xi64>
    %6 = tosa.bitwise_and %5, %5 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %7 = tosa.logical_right_shift %5, %5 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %8 = tosa.bitwise_or %7, %5 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %9 = tosa.tanh %4 : (tensor<4xf32>) -> tensor<4xf32>
    %10 = tosa.minimum %8, %8 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %11 = tosa.clz %6 : (tensor<6xi64>) -> tensor<6xi64>
    %cast = tensor.cast %9 : tensor<4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<6xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %11 : tensor<6xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}


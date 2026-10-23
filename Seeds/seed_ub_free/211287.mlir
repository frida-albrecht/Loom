module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<108> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<-178> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<1.749600e+02> : tensor<7x1xf32>}> : () -> tensor<7x1xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.tanh %2 : (tensor<7x1xf32>) -> tensor<7x1xf32>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<7x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


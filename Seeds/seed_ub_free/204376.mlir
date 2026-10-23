module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<109> : tensor<3xi64>}> : () -> tensor<3xi64>
    %1 = "tosa.const"() <{values = dense<169> : tensor<3xi64>}> : () -> tensor<3xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3xi64>}> : () -> tensor<3xi64>
    %s0 = tosa.maximum %1, %c0 : (tensor<3xi64>, tensor<3xi64>) -> tensor<3xi64>
    %c1 = "tosa.const"() <{values = dense<63> : tensor<3xi64>}> : () -> tensor<3xi64>
    %s1 = tosa.minimum %s0, %c1 : (tensor<3xi64>, tensor<3xi64>) -> tensor<3xi64>
    %2 = tosa.logical_right_shift %0, %s1 : (tensor<3xi64>, tensor<3xi64>) -> tensor<3xi64>
    %cast = tensor.cast %2 : tensor<3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
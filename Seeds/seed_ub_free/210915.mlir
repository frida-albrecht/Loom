module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<180> : tensor<2x2xi64>}> : () -> tensor<2x2xi64>
    %1 = "tosa.const"() <{values = dense<68> : tensor<2x1xi64>}> : () -> tensor<2x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<2x1xi64>}> : () -> tensor<2x1xi64>
    %s1 = tosa.minimum %1, %c63 : (tensor<2x1xi64>, tensor<2x1xi64>) -> tensor<2x1xi64>
    %2 = tosa.logical_right_shift %0, %s1 : (tensor<2x2xi64>, tensor<2x1xi64>) -> tensor<2x2xi64>
    %cast = tensor.cast %2 : tensor<2x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
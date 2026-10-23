module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<76> : tensor<1x7x8xi64>}> : () -> tensor<1x7x8xi64>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.negate %0, %1, %2 : (tensor<1x7x8xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1x7x8xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x7x8xi64>}> : () -> tensor<1x7x8xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x7x8xi64>}> : () -> tensor<1x7x8xi64>
    %m0 = tosa.maximum %3, %c0 : (tensor<1x7x8xi64>, tensor<1x7x8xi64>) -> tensor<1x7x8xi64>
    %m1 = tosa.minimum %m0, %c63 : (tensor<1x7x8xi64>, tensor<1x7x8xi64>) -> tensor<1x7x8xi64>
    %4 = tosa.arithmetic_right_shift %3, %m1 {round = false} : (tensor<1x7x8xi64>, tensor<1x7x8xi64>) -> tensor<1x7x8xi64>
    %5 = tosa.bitwise_or %4, %4 : (tensor<1x7x8xi64>, tensor<1x7x8xi64>) -> tensor<1x7x8xi64>
    %cast = tensor.cast %5 : tensor<1x7x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
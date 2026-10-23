module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<2x2x7x8xi64>}> : () -> tensor<2x2x7x8xi64>
    %1 = "tosa.const"() <{values = dense<140> : tensor<1x2x7x8xi64>}> : () -> tensor<1x2x7x8xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<2x2x7x8xi64>, tensor<1x2x7x8xi64>) -> tensor<2x2x7x8xi64>
    %3 = tosa.abs %2 : (tensor<2x2x7x8xi64>) -> tensor<2x2x7x8xi64>
    %4 = tosa.bitwise_or %3, %2 : (tensor<2x2x7x8xi64>, tensor<2x2x7x8xi64>) -> tensor<2x2x7x8xi64>
    %cast = tensor.cast %4 : tensor<2x2x7x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


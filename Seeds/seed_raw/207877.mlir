module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-23> : tensor<9x7xi64>}> : () -> tensor<9x7xi64>
    %1 = "tosa.const"() <{values = dense<133> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<9x7xi64>, tensor<1x1xi64>) -> tensor<9x7xi64>
    %cast = tensor.cast %2 : tensor<9x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


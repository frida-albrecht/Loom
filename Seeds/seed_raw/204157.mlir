module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-111> : tensor<6x3x10xi64>}> : () -> tensor<6x3x10xi64>
    %1 = "tosa.const"() <{values = dense<-66> : tensor<6x1x1xi64>}> : () -> tensor<6x1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<6x3x10xi64>, tensor<6x1x1xi64>) -> tensor<6x3x10xi64>
    %cast = tensor.cast %2 : tensor<6x3x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


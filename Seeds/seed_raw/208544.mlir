module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<81> : tensor<10xi64>}> : () -> tensor<10xi64>
    %1 = "tosa.const"() <{values = dense<120> : tensor<10xi64>}> : () -> tensor<10xi64>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<10xi64>, tensor<10xi64>) -> tensor<10xi64>
    %cast = tensor.cast %2 : tensor<10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


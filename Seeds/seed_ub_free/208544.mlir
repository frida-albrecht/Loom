module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<81> : tensor<10xi64>}> : () -> tensor<10xi64>
    %1 = "tosa.const"() <{values = dense<120> : tensor<10xi64>}> : () -> tensor<10xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<10xi64>}> : () -> tensor<10xi64>
    %s0 = tosa.minimum %1, %c63 : (tensor<10xi64>, tensor<10xi64>) -> tensor<10xi64>
    %2 = tosa.arithmetic_right_shift %0, %s0 {round = false} : (tensor<10xi64>, tensor<10xi64>) -> tensor<10xi64>
    %cast = tensor.cast %2 : tensor<10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
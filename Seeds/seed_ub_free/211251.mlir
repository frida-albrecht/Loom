module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<192> : tensor<8xi64>}> : () -> tensor<8xi64>
    %1 = "tosa.const"() <{values = dense<166> : tensor<8xi64>}> : () -> tensor<8xi64>
    %2 = tosa.add %0, %1 : (tensor<8xi64>, tensor<8xi64>) -> tensor<8xi64>
    %cast = tensor.cast %2 : tensor<8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<88> : tensor<9x10x10xi64>}> : () -> tensor<9x10x10xi64>
    %1 = tosa.bitwise_not %0 : (tensor<9x10x10xi64>) -> tensor<9x10x10xi64>
    %2 = tosa.bitwise_not %1 : (tensor<9x10x10xi64>) -> tensor<9x10x10xi64>
    %cast = tensor.cast %2 : tensor<9x10x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


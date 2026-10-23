module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<118> : tensor<8xi64>}> : () -> tensor<8xi64>
    %1 = tosa.abs %0 : (tensor<8xi64>) -> tensor<8xi64>
    %cast = tensor.cast %1 : tensor<8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


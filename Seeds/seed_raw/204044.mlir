module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<171> : tensor<3x1xi64>}> : () -> tensor<3x1xi64>
    %1 = tosa.bitwise_not %0 : (tensor<3x1xi64>) -> tensor<3x1xi64>
    %cast = tensor.cast %1 : tensor<3x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


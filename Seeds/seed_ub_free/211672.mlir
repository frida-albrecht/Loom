module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<2x9x4x7xi64>}> : () -> tensor<2x9x4x7xi64>
    %1 = tosa.bitwise_not %0 : (tensor<2x9x4x7xi64>) -> tensor<2x9x4x7xi64>
    %2 = tosa.sub %1, %1 : (tensor<2x9x4x7xi64>, tensor<2x9x4x7xi64>) -> tensor<2x9x4x7xi64>
    %cast = tensor.cast %2 : tensor<2x9x4x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


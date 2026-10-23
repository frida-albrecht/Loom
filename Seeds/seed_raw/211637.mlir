module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-172> : tensor<8x1x1xi64>}> : () -> tensor<8x1x1xi64>
    %1 = "tosa.const"() <{values = dense<111> : tensor<8x1x1xi64>}> : () -> tensor<8x1x1xi64>
    %2 = tosa.bitwise_or %0, %1 : (tensor<8x1x1xi64>, tensor<8x1x1xi64>) -> tensor<8x1x1xi64>
    %cast = tensor.cast %2 : tensor<8x1x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<1x3xi64>}> : () -> tensor<1x3xi64>
    %1 = "tosa.const"() <{values = dense<94> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.bitwise_and %0, %1 : (tensor<1x3xi64>, tensor<1x1xi64>) -> tensor<1x3xi64>
    %cast = tensor.cast %2 : tensor<1x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


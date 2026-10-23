module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-135> : tensor<2x2x5xi64>}> : () -> tensor<2x2x5xi64>
    %1 = "tosa.const"() <{values = dense<-60> : tensor<1x1x5xi64>}> : () -> tensor<1x1x5xi64>
    %2 = tosa.maximum %0, %1 : (tensor<2x2x5xi64>, tensor<1x1x5xi64>) -> tensor<2x2x5xi64>
    %3 = tosa.bitwise_not %2 : (tensor<2x2x5xi64>) -> tensor<2x2x5xi64>
    %cast = tensor.cast %3 : tensor<2x2x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


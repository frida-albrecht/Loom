module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-39> : tensor<5x1x2xi64>}> : () -> tensor<5x1x2xi64>
    %1 = "tosa.const"() <{values = dense<36> : tensor<1x1x2xi64>}> : () -> tensor<1x1x2xi64>
    %2 = tosa.sub %0, %1 : (tensor<5x1x2xi64>, tensor<1x1x2xi64>) -> tensor<5x1x2xi64>
    %cast = tensor.cast %2 : tensor<5x1x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


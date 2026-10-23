module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<117> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<-147> : tensor<2xi64>}> : () -> tensor<2xi64>
    %2 = tosa.maximum %0, %1 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %cast = tensor.cast %3 : tensor<2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


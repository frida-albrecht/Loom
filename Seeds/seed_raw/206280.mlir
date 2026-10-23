module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-109> : tensor<6x7xi64>}> : () -> tensor<6x7xi64>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<6x1xi64>}> : () -> tensor<6x1xi64>
    %2 = tosa.maximum %0, %1 : (tensor<6x7xi64>, tensor<6x1xi64>) -> tensor<6x7xi64>
    %cast = tensor.cast %2 : tensor<6x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-121> : tensor<4xi64>}> : () -> tensor<4xi64>
    %1 = "tosa.const"() <{values = dense<-67> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = tosa.minimum %0, %1 : (tensor<4xi64>, tensor<1xi64>) -> tensor<4xi64>
    %cast = tensor.cast %2 : tensor<4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


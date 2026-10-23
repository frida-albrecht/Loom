module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-65> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = "tosa.const"() <{values = dense<-5> : tensor<7xi64>}> : () -> tensor<7xi64>
    %2 = tosa.bitwise_and %0, %1 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %cast = tensor.cast %2 : tensor<7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


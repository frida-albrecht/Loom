module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<3x5x6xi64>}> : () -> tensor<3x5x6xi64>
    %1 = "tosa.const"() <{values = dense<-89> : tensor<1x5x6xi64>}> : () -> tensor<1x5x6xi64>
    %2 = tosa.bitwise_and %0, %1 : (tensor<3x5x6xi64>, tensor<1x5x6xi64>) -> tensor<3x5x6xi64>
    %cast = tensor.cast %2 : tensor<3x5x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


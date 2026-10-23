module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-21> : tensor<6x1x5x6xi64>}> : () -> tensor<6x1x5x6xi64>
    %1 = tosa.identity %0 : (tensor<6x1x5x6xi64>) -> tensor<6x1x5x6xi64>
    %cast = tensor.cast %1 : tensor<6x1x5x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-14> : tensor<1x3x6xi64>}> : () -> tensor<1x3x6xi64>
    %1 = "tosa.const"() <{values = dense<-150> : tensor<1x1x1xi64>}> : () -> tensor<1x1x1xi64>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<1x3x6xi64>, tensor<1x1x1xi64>) -> tensor<1x3x6xi64>
    %cast = tensor.cast %2 : tensor<1x3x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


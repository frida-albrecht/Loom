module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-160> : tensor<1x10x4x2xi64>}> : () -> tensor<1x10x4x2xi64>
    %1 = tosa.bitwise_not %0 : (tensor<1x10x4x2xi64>) -> tensor<1x10x4x2xi64>
    %cast = tensor.cast %1 : tensor<1x10x4x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73> : tensor<5x4xi64>}> : () -> tensor<5x4xi64>
    %1 = tosa.clz %0 : (tensor<5x4xi64>) -> tensor<5x4xi64>
    %cast = tensor.cast %1 : tensor<5x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


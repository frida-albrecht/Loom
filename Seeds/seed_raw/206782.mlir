module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-98> : tensor<i64>}> : () -> tensor<i64>
    %1 = tosa.abs %0 : (tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %1 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<81> : tensor<i64>}> : () -> tensor<i64>
    %1 = tosa.clz %0 : (tensor<i64>) -> tensor<i64>
    %2 = tosa.abs %1 : (tensor<i64>) -> tensor<i64>
    %3 = tosa.add %2, %2 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


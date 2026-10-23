module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-61> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<-157> : tensor<i64>}> : () -> tensor<i64>
    %2 = tosa.bitwise_and %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %3 = tosa.clamp %2 {max_val = -8 : i64, min_val = -43 : i64} : (tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


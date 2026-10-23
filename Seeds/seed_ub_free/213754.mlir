module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<175> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<-151> : tensor<i64>}> : () -> tensor<i64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i64>}> : () -> tensor<i64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<i64>}> : () -> tensor<i64>
    %a1 = tosa.maximum %1, %c0 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %b2 = tosa.minimum %a1, %c63 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %2 = tosa.logical_left_shift %0, %b2 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %2 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
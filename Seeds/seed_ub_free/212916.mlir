module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-133> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<-91> : tensor<2xi64>}> : () -> tensor<2xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2xi64>}> : () -> tensor<2xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<2xi64>}> : () -> tensor<2xi64>
    %a1 = tosa.maximum %1, %c0 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %b2 = tosa.minimum %a1, %c63 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %2 = tosa.logical_left_shift %0, %b2 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %3 = tosa.clamp %2 {max_val = 159 : i64, min_val = 43 : i64} : (tensor<2xi64>) -> tensor<2xi64>
    %cast = tensor.cast %3 : tensor<2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
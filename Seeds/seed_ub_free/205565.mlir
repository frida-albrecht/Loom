module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<181> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.negate %0, %1, %2 : (tensor<i64>, tensor<1xi64>, tensor<1xi64>) -> tensor<i64>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<127> : tensor<10xi64>}> : () -> tensor<10xi64>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<10xi64>) -> tensor<10xi64>
    %2 = tosa.clamp %1 {max_val = 24 : i64, min_val = -42 : i64} : (tensor<10xi64>) -> tensor<10xi64>
    %3 = tosa.identity %2 : (tensor<10xi64>) -> tensor<10xi64>
    %cast = tensor.cast %3 : tensor<10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


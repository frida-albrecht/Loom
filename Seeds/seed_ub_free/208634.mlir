module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<198> : tensor<9x5xi64>}> : () -> tensor<9x5xi64>
    %1 = tosa.clamp %0 {max_val = 39 : i64, min_val = 18 : i64} : (tensor<9x5xi64>) -> tensor<9x5xi64>
    %cast = tensor.cast %1 : tensor<9x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


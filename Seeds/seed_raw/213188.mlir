module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-48> : tensor<7x10x7xi64>}> : () -> tensor<7x10x7xi64>
    %1 = tosa.clamp %0 {max_val = 17 : i64, min_val = -44 : i64} : (tensor<7x10x7xi64>) -> tensor<7x10x7xi64>
    %cast = tensor.cast %1 : tensor<7x10x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


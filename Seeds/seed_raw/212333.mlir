module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-192> : tensor<6x8x8x6xi64>}> : () -> tensor<6x8x8x6xi64>
    %1 = tosa.clamp %0 {max_val = -6 : i64, min_val = -50 : i64} : (tensor<6x8x8x6xi64>) -> tensor<6x8x8x6xi64>
    %cast = tensor.cast %1 : tensor<6x8x8x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


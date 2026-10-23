module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-167> : tensor<4x6x3xi64>}> : () -> tensor<4x6x3xi64>
    %1 = tosa.clamp %0 {max_val = 55 : i64, min_val = -14 : i64} : (tensor<4x6x3xi64>) -> tensor<4x6x3xi64>
    %2 = tosa.identity %1 : (tensor<4x6x3xi64>) -> tensor<4x6x3xi64>
    %cast = tensor.cast %2 : tensor<4x6x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


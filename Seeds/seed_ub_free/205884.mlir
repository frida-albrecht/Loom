module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<3x9x8x5xi64>}> : () -> tensor<3x9x8x5xi64>
    %1 = "tosa.const"() <{values = dense<-3.142000e+01> : tensor<5x5xf32>}> : () -> tensor<5x5xf32>
    %2 = tosa.clamp %0 {max_val = 60 : i64, min_val = 10 : i64} : (tensor<3x9x8x5xi64>) -> tensor<3x9x8x5xi64>
    %3 = tosa.floor %1 : (tensor<5x5xf32>) -> tensor<5x5xf32>
    %cast = tensor.cast %2 : tensor<3x9x8x5xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %3 : tensor<5x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<89> : tensor<10xi64>}> : () -> tensor<10xi64>
    %1 = "tosa.const"() <{values = dense<114> : tensor<10xi64>}> : () -> tensor<10xi64>
    %2 = "tosa.const"() <{values = dense<-8.381000e+01> : tensor<5x5x9x8xf32>}> : () -> tensor<5x5x9x8xf32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<10xi64>, tensor<10xi64>) -> tensor<10xi64>
    %4 = tosa.reciprocal %2 : (tensor<5x5x9x8xf32>) -> tensor<5x5x9x8xf32>
    %cast = tensor.cast %3 : tensor<10xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<5x5x9x8xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


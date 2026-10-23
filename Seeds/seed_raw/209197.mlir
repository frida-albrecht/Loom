module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.739000e+01> : tensor<10x3x4xf32>}> : () -> tensor<10x3x4xf32>
    %1 = tosa.reciprocal %0 : (tensor<10x3x4xf32>) -> tensor<10x3x4xf32>
    %cast = tensor.cast %1 : tensor<10x3x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


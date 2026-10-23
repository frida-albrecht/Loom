module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.944000e+02> : tensor<5x8x6xf32>}> : () -> tensor<5x8x6xf32>
    %1 = "tosa.const"() <{values = dense<2.504000e+01> : tensor<5x8x1xf32>}> : () -> tensor<5x8x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<5x8x6xf32>, tensor<5x8x1xf32>) -> tensor<5x8x6xf32>
    %3 = tosa.tanh %2 : (tensor<5x8x6xf32>) -> tensor<5x8x6xf32>
    %cast = tensor.cast %3 : tensor<5x8x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


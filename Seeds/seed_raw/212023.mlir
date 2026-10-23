module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.142500e+02> : tensor<2x3x7x4xf32>}> : () -> tensor<2x3x7x4xf32>
    %1 = tosa.rsqrt %0 : (tensor<2x3x7x4xf32>) -> tensor<2x3x7x4xf32>
    %cast = tensor.cast %1 : tensor<2x3x7x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


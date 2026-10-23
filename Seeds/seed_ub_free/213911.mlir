module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.750000e+00> : tensor<4x3x4x3xf32>}> : () -> tensor<4x3x4x3xf32>
    %1 = tosa.rsqrt %0 : (tensor<4x3x4x3xf32>) -> tensor<4x3x4x3xf32>
    %cast = tensor.cast %1 : tensor<4x3x4x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


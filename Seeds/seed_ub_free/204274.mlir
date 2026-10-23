module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.612000e+02> : tensor<4x3x9x6xf32>}> : () -> tensor<4x3x9x6xf32>
    %1 = "tosa.const"() <{values = dense<2.320000e+00> : tensor<4x3x1x6xf32>}> : () -> tensor<4x3x1x6xf32>
    %2 = tosa.pow %0, %1 : (tensor<4x3x9x6xf32>, tensor<4x3x1x6xf32>) -> tensor<4x3x9x6xf32>
    %cast = tensor.cast %2 : tensor<4x3x9x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


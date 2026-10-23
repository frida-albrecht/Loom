module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.738300e+02> : tensor<10x4x8x9xf32>}> : () -> tensor<10x4x8x9xf32>
    %1 = tosa.ceil %0 : (tensor<10x4x8x9xf32>) -> tensor<10x4x8x9xf32>
    %2 = tosa.ceil %1 : (tensor<10x4x8x9xf32>) -> tensor<10x4x8x9xf32>
    %cast = tensor.cast %2 : tensor<10x4x8x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


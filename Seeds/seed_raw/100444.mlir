module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.874800e+02> : tensor<1x1x3x1x3xf32>}> : () -> tensor<1x1x3x1x3xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0, 0, 0, 0] [1, 1, 3, 1, 3] [1, 1, 1, 1, 1] : tensor<1x1x3x1x3xf32> to tensor<1x3x3xf32>
    %cast = tensor.cast %extracted_slice : tensor<1x3x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


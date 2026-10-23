module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.860900e+02> : tensor<32x64x16xf32>}> : () -> tensor<32x64x16xf32>
    %1 = tensor.empty() : tensor<8x2x32x16x4xf32>
    %expanded = tensor.expand_shape %0 [[0], [1, 2], [3]] output_shape [32, 2, 32, 16] : tensor<32x64x16xf32> into tensor<32x2x32x16xf32>
    %pack = linalg.pack %expanded inner_dims_pos = [0] inner_tiles = [4] into %1 : tensor<32x2x32x16xf32> -> tensor<8x2x32x16x4xf32>
    %cast = tensor.cast %pack : tensor<8x2x32x16x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.324000e+01> : tensor<32x64x16xf32>}> : () -> tensor<32x64x16xf32>
    %1 = tensor.empty() : tensor<4x2x2x8x16x4x4xf32>
    %expanded = tensor.expand_shape %0 [[0, 1], [2, 3], [4]] output_shape [4, 8, 2, 32, 16] : tensor<32x64x16xf32> into tensor<4x8x2x32x16xf32>
    %pack = linalg.pack %expanded inner_dims_pos = [1, 3] inner_tiles = [4, 4] into %1 : tensor<4x8x2x32x16xf32> -> tensor<4x2x2x8x16x4x4xf32>
    %cast = tensor.cast %pack : tensor<4x2x2x8x16x4x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


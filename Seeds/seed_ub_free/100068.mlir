module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.716000e+01> : tensor<4x192x16x256xf32>}> : () -> tensor<4x192x16x256xf32>
    %collapsed = tensor.collapse_shape %0 [[0], [1, 2], [3]] : tensor<4x192x16x256xf32> into tensor<4x3072x256xf32>
    %1 = tensor.empty() : tensor<4x32x3072x8x1xf32>
    %pack = linalg.pack %collapsed outer_dims_perm = [0, 2, 1] inner_dims_pos = [2, 1] inner_tiles = [8, 1] into %1 : tensor<4x3072x256xf32> -> tensor<4x32x3072x8x1xf32>
    %cast = tensor.cast %pack : tensor<4x32x3072x8x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


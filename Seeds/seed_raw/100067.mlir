module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.516000e+01> : tensor<1x64x1x4xf32>}> : () -> tensor<1x64x1x4xf32>
    %collapsed = tensor.collapse_shape %0 [[0, 1, 2], [3]] : tensor<1x64x1x4xf32> into tensor<64x4xf32>
    %1 = tensor.empty() : tensor<8x4x8x1xf32>
    %pack = linalg.pack %collapsed outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [8, 1] into %1 : tensor<64x4xf32> -> tensor<8x4x8x1xf32>
    %cast = tensor.cast %pack : tensor<8x4x8x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.908000e+02> : tensor<3072x64x4xf32>}> : () -> tensor<3072x64x4xf32>
    %collapsed = tensor.collapse_shape %0 [[0], [1, 2]] : tensor<3072x64x4xf32> into tensor<3072x256xf32>
    %1 = tensor.empty() : tensor<384x32x8x8xf32>
    %pack = linalg.pack %collapsed outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<3072x256xf32> -> tensor<384x32x8x8xf32>
    %cast = tensor.cast %pack : tensor<384x32x8x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


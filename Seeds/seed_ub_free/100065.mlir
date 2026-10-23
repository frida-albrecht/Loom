module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.781500e+02> : tensor<32x64xf32>}> : () -> tensor<32x64xf32>
    %1 = tensor.empty() : tensor<4x2x32x4x2xf32>
    %expanded = tensor.expand_shape %0 [[0, 1], [2]] output_shape [4, 8, 64] : tensor<32x64xf32> into tensor<4x8x64xf32>
    %pack = linalg.pack %expanded outer_dims_perm = [0, 1, 2] inner_dims_pos = [1, 2] inner_tiles = [4, 2] into %1 : tensor<4x8x64xf32> -> tensor<4x2x32x4x2xf32>
    %cast = tensor.cast %pack : tensor<4x2x32x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


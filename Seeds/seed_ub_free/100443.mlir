module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.056000e+01> : tensor<6x32x8x8xf32>}> : () -> tensor<6x32x8x8xf32>
    %1 = tensor.empty() : tensor<48x256xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<6x32x8x8xf32> -> tensor<48x256xf32>
    %expanded = tensor.expand_shape %unpack [[0, 1, 2], [3]] output_shape [3, 16, 1, 256] : tensor<48x256xf32> into tensor<3x16x1x256xf32>
    %cast = tensor.cast %expanded : tensor<3x16x1x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


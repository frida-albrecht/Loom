module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.880000e+01> : tensor<384x32x8x8xf32>}> : () -> tensor<384x32x8x8xf32>
    %1 = tensor.empty() : tensor<3072x256xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<384x32x8x8xf32> -> tensor<3072x256xf32>
    %expanded = tensor.expand_shape %unpack [[0, 1], [2]] output_shape [256, 12, 256] : tensor<3072x256xf32> into tensor<256x12x256xf32>
    %cast = tensor.cast %expanded : tensor<256x12x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


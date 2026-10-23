module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.136100e+02> : tensor<4x32x384x8x8xf32>}> : () -> tensor<4x32x384x8x8xf32>
    %1 = tensor.empty() : tensor<4x3072x256xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 2, 1] inner_dims_pos = [2, 1] inner_tiles = [8, 8] into %1 : tensor<4x32x384x8x8xf32> -> tensor<4x3072x256xf32>
    %expanded = tensor.expand_shape %unpack [[0], [1, 2], [3]] output_shape [4, 12, 256, 256] : tensor<4x3072x256xf32> into tensor<4x12x256x256xf32>
    %cast = tensor.cast %expanded : tensor<4x12x256x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


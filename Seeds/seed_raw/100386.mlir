module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<96.0599975> : tensor<128x256xf32>}> : () -> tensor<128x256xf32>
    %1 = "tosa.const"() <{values = dense<1.602800e+02> : tensor<16x4x32x16xf32>}> : () -> tensor<16x4x32x16xf32>
    %pack = linalg.pack %0 outer_dims_perm = [1, 0] inner_dims_pos = [0, 1] inner_tiles = [32, 16] into %1 : tensor<128x256xf32> -> tensor<16x4x32x16xf32>
    %2 = tensor.empty() : tensor<128x256xf32>
    %unpack = linalg.unpack %pack outer_dims_perm = [1, 0] inner_dims_pos = [0, 1] inner_tiles = [32, 16] into %2 : tensor<16x4x32x16xf32> -> tensor<128x256xf32>
    %cast = tensor.cast %unpack : tensor<128x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.504000e+01> : tensor<2x1x16x8x32xf32>}> : () -> tensor<2x1x16x8x32xf32>
    %1 = "tosa.const"() <{values = dense<7.102000e+01> : tensor<2x32x16x8xf32>}> : () -> tensor<2x32x16x8xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [1] inner_tiles = [32] into %1 : tensor<2x1x16x8x32xf32> -> tensor<2x32x16x8xf32>
    %cast = tensor.cast %unpack : tensor<2x32x16x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


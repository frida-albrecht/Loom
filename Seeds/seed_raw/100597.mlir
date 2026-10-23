module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.042000e+01> : tensor<1x1x32x64xf32>}> : () -> tensor<1x1x32x64xf32>
    %1 = tensor.empty() : tensor<64x32xf32>
    %unpack = linalg.unpack %0 inner_dims_pos = [1, 0] inner_tiles = [32, 64] into %1 : tensor<1x1x32x64xf32> -> tensor<64x32xf32>
    %cast = tensor.cast %unpack : tensor<64x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


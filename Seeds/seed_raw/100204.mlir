module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.430000e+00> : tensor<128x256xf32>}> : () -> tensor<128x256xf32>
    %cst = arith.constant dense<1.000000e-01> : tensor<16x8x8x32xf32>
    %unpack = linalg.unpack %cst inner_dims_pos = [0, 1] inner_tiles = [8, 32] into %0 : tensor<16x8x8x32xf32> -> tensor<128x256xf32>
    %cast = tensor.cast %unpack : tensor<128x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


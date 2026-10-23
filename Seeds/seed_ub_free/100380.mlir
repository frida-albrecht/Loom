module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.070000e+01> : tensor<32x1xf32>}> : () -> tensor<32x1xf32>
    %1 = tensor.empty() : tensor<16x1x1x2xf32>
    %pack = linalg.pack %0 inner_dims_pos = [1, 0] inner_tiles = [1, 2] into %1 : tensor<32x1xf32> -> tensor<16x1x1x2xf32>
    %cast = tensor.cast %pack : tensor<16x1x1x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


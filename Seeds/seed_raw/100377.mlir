module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.151000e+01> : tensor<64xf32>}> : () -> tensor<64xf32>
    %1 = tensor.empty() : tensor<2x32xf32>
    %pack = linalg.pack %0 outer_dims_perm = [0] inner_dims_pos = [0] inner_tiles = [32] into %1 : tensor<64xf32> -> tensor<2x32xf32>
    %cast = tensor.cast %pack : tensor<2x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


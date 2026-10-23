module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.233000e+01> : tensor<5x256xf32>}> : () -> tensor<5x256xf32>
    %1 = tensor.empty() : tensor<5x8x32xf32>
    %pack = linalg.pack %0 outer_dims_perm = [0, 1] inner_dims_pos = [1] inner_tiles = [32] into %1 : tensor<5x256xf32> -> tensor<5x8x32xf32>
    %cast = tensor.cast %pack : tensor<5x8x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


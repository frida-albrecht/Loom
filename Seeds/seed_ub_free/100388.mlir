module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.543000e+01> : tensor<3x5x7xf32>}> : () -> tensor<3x5x7xf32>
    %1 = "tosa.const"() <{values = dense<1.021600e+02> : tensor<3x7x5xf32>}> : () -> tensor<3x7x5xf32>
    %pack = linalg.pack %0 outer_dims_perm = [0, 2, 1] inner_dims_pos = [] inner_tiles = [] into %1 : tensor<3x5x7xf32> -> tensor<3x7x5xf32>
    %cast = tensor.cast %pack : tensor<3x7x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.269000e+01> : tensor<8x16x8x32xf32>}> : () -> tensor<8x16x8x32xf32>
    %cst = arith.constant 1.000000e-01 : f32
    %cst_0 = arith.constant dense<1.000000e-01> : tensor<63x127xf32>
    %pack = linalg.pack %cst_0 padding_value(%cst : f32) outer_dims_perm = [1, 0] inner_dims_pos = [0, 1] inner_tiles = [8, 32] into %0 : tensor<63x127xf32> -> tensor<8x16x8x32xf32>
    %cast = tensor.cast %pack : tensor<8x16x8x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.780000e+01> : tensor<1x2x56x56x32xf32>}> : () -> tensor<1x2x56x56x32xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = tensor.empty() : tensor<1x56x56x64xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 3, 1, 2] inner_dims_pos = [3] inner_tiles = [32] into %1 : tensor<1x2x56x56x32xf32> -> tensor<1x56x56x64xf32>
    %padded = tensor.pad %unpack low[1, 1, 1, 0] high[0, 1, 1, 0] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
      tensor.yield %cst : f32
    } : tensor<1x56x56x64xf32> to tensor<2x58x58x64xf32>
    %cast = tensor.cast %padded : tensor<2x58x58x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


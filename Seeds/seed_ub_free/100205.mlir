#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.048000e+01> : tensor<12x2x56x56x32xf32>}> : () -> tensor<12x2x56x56x32xf32>
    %1 = tensor.empty() : tensor<12x56x56x64xf32>
    %2 = tensor.empty() : tensor<12x56x56x64xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 3, 1, 2] inner_dims_pos = [3] inner_tiles = [32] into %2 : tensor<12x2x56x56x32xf32> -> tensor<12x56x56x64xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%unpack : tensor<12x56x56x64xf32>) outs(%1 : tensor<12x56x56x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.addf %in, %in : f32
      linalg.yield %4 : f32
    } -> tensor<12x56x56x64xf32>
    %cast = tensor.cast %3 : tensor<12x56x56x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


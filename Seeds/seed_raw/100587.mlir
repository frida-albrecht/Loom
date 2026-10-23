#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.113700e+02> : tensor<12x2x56x56x32xf32>}> : () -> tensor<12x2x56x56x32xf32>
    %1 = tensor.empty() : tensor<12x56x56x64xf32>
    %unpack = linalg.unpack %0 outer_dims_perm = [0, 3, 1, 2] inner_dims_pos = [3] inner_tiles = [32] into %1 : tensor<12x2x56x56x32xf32> -> tensor<12x56x56x64xf32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%unpack : tensor<12x56x56x64xf32>) {
    ^bb0(%out: f32):
      %3 = arith.addf %out, %out : f32
      linalg.yield %3 : f32
    } -> tensor<12x56x56x64xf32>
    %cast = tensor.cast %2 : tensor<12x56x56x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


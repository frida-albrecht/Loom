#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.380800e+02> : tensor<2x16x8xf32>}> : () -> tensor<2x16x8xf32>
    %1 = "tosa.const"() <{values = dense<1.143100e+02> : tensor<2x8x16xf32>}> : () -> tensor<2x8x16xf32>
    %2 = "tosa.const"() <{values = dense<6.758000e+01> : tensor<2x16x16xf32>}> : () -> tensor<2x16x16xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%0, %1 : tensor<2x16x8xf32>, tensor<2x8x16xf32>) outs(%2 : tensor<2x16x16xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.mulf %in, %in_0 : f32
      %5 = arith.addf %out, %4 : f32
      linalg.yield %5 : f32
    } -> tensor<2x16x16xf32>
    %cast = tensor.cast %3 : tensor<2x16x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.489000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<1.140300e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tensor.empty() : tensor<4xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel"]} ins(%0, %1 : tensor<4xf32>, tensor<1xf32>) outs(%2 : tensor<4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.divf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<4xf32>
    %cast = tensor.cast %3 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


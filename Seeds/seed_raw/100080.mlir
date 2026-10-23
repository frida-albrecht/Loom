#map = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.278000e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<5.304000e+01> : tensor<20xf32>}> : () -> tensor<20xf32>
    %expanded = tensor.expand_shape %0 [[0, 1]] output_shape [2, 3] : tensor<6xf32> into tensor<2x3xf32>
    %expanded_0 = tensor.expand_shape %1 [[0, 1]] output_shape [4, 5] : tensor<20xf32> into tensor<4x5xf32>
    %2 = tensor.empty() : tensor<2x3x4x5xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded, %expanded_0 : tensor<2x3xf32>, tensor<4x5xf32>) outs(%2 : tensor<2x3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %4 = arith.addf %in, %in_1 : f32
      linalg.yield %4 : f32
    } -> tensor<2x3x4x5xf32>
    %cast = tensor.cast %3 : tensor<2x3x4x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


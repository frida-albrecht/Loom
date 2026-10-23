#map = affine_map<(d0, d1, d2) -> (d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.803700e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tensor.empty() : tensor<1x2x5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%0 : tensor<5xf32>) outs(%1 : tensor<1x2x5xf32>) attrs =  {i64} {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x5xf32>
    %collapsed = tensor.collapse_shape %2 [[0, 1], [2]] : tensor<1x2x5xf32> into tensor<2x5xf32>
    %cast = tensor.cast %collapsed : tensor<2x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


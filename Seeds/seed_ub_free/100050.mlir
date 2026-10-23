#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.670400e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = "tosa.const"() <{values = dense<8.061000e+01> : tensor<5xf32>}> : () -> tensor<5xf32>
    %2 = "tosa.const"() <{values = dense<1.686000e+02> : tensor<5x5xf32>}> : () -> tensor<5x5xf32>
    %expanded = tensor.expand_shape %0 [[0, 1]] output_shape [1, 5] : tensor<5xf32> into tensor<1x5xf32>
    %expanded_0 = tensor.expand_shape %1 [[0, 1]] output_shape [5, 1] : tensor<5xf32> into tensor<5x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel"], library_call = "some_external_fn"} ins(%expanded, %expanded_0 : tensor<1x5xf32>, tensor<5x1xf32>) outs(%2 : tensor<5x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %4 = arith.addf %in, %in_1 : f32
      linalg.yield %4 : f32
    } -> tensor<5x5xf32>
    %cast = tensor.cast %3 : tensor<5x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


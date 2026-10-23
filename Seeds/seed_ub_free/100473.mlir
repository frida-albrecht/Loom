#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<64.3899993> : tensor<12544x16xf32>}> : () -> tensor<12544x16xf32>
    %1 = "tosa.const"() <{values = dense<1.366300e+02> : tensor<112xf32>}> : () -> tensor<112xf32>
    %expanded = tensor.expand_shape %0 [[0, 1], [2]] output_shape [112, 112, 16] : tensor<12544x16xf32> into tensor<112x112x16xf32>
    %2 = tensor.empty() : tensor<112x112x16xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%expanded, %1 : tensor<112x112x16xf32>, tensor<112xf32>) outs(%2 : tensor<112x112x16xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.subf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<112x112x16xf32>
    %cast = tensor.cast %3 : tensor<112x112x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


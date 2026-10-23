#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.274000e+01> : tensor<12544x16xf32>}> : () -> tensor<12544x16xf32>
    %1 = "tosa.const"() <{values = dense<-1.130800e+02> : tensor<12544x16xf32>}> : () -> tensor<12544x16xf32>
    %2 = "tosa.const"() <{values = dense<1.968100e+02> : tensor<16xf32>}> : () -> tensor<16xf32>
    %expanded = tensor.expand_shape %0 [[0, 1], [2]] output_shape [112, 112, 16] : tensor<12544x16xf32> into tensor<112x112x16xf32>
    %expanded_0 = tensor.expand_shape %1 [[0, 1], [2]] output_shape [112, 112, 16] : tensor<12544x16xf32> into tensor<112x112x16xf32>
    %3 = tensor.empty() : tensor<112x112x16xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%expanded, %expanded_0, %2 : tensor<112x112x16xf32>, tensor<112x112x16xf32>, tensor<16xf32>) outs(%3 : tensor<112x112x16xf32>) {
    ^bb0(%in: f32, %in_1: f32, %in_2: f32, %out: f32):
      %5 = arith.subf %in, %in_1 : f32
      %6 = arith.mulf %5, %in_2 : f32
      linalg.yield %6 : f32
    } -> tensor<112x112x16xf32>
    %cast = tensor.cast %4 : tensor<112x112x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


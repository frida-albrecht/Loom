#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (0, d0)>
#map2 = affine_map<(d0) -> (0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.088900e+02> : tensor<1x10xf32>}> : () -> tensor<1x10xf32>
    %1 = "tosa.const"() <{values = dense<-1.410500e+02> : tensor<1x10xf32>}> : () -> tensor<1x10xf32>
    %2 = "tosa.const"() <{values = dense<3.699000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tensor.empty() : tensor<1x10xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%0, %1 : tensor<1x10xf32>, tensor<1x10xf32>) outs(%3 : tensor<1x10xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %6 = arith.addf %in, %in_0 : f32
      linalg.yield %6 : f32
    } -> tensor<1x10xf32>
    %5 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["reduction"]} ins(%4 : tensor<1x10xf32>) outs(%2 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %6 = arith.addf %in, %out : f32
      linalg.yield %6 : f32
    } -> tensor<1xf32>
    %cast = tensor.cast %5 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


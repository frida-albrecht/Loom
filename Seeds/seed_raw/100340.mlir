#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.786000e+01> : tensor<512xf32>}> : () -> tensor<512xf32>
    %1 = "tosa.const"() <{values = dense<-4.539000e+01> : tensor<512xf32>}> : () -> tensor<512xf32>
    %2 = "tosa.const"() <{values = dense<-3.287000e+01> : tensor<512xf32>}> : () -> tensor<512xf32>
    %3 = "tosa.const"() <{values = dense<-4.626000e+01> : tensor<200x512xf32>}> : () -> tensor<200x512xf32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map, #map, #map1], iterator_types = ["parallel", "parallel"]} ins(%0, %1 : tensor<512xf32>, tensor<512xf32>) outs(%2, %3 : tensor<512xf32>, tensor<200x512xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32, %out_1: f32):
      %5 = arith.addf %in, %in_0 : f32
      linalg.yield %5, %5 : f32, f32
    } -> (tensor<512xf32>, tensor<200x512xf32>)
    %expanded = tensor.expand_shape %4#1 [[0, 1, 2], [3]] output_shape [25, 8, 1, 512] : tensor<200x512xf32> into tensor<25x8x1x512xf32>
    %cast = tensor.cast %expanded : tensor<25x8x1x512xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


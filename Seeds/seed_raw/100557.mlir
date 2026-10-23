#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.368100e+02> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %1 = "tosa.const"() <{values = dense<4.930000e+00> : tensor<3x2xf32>}> : () -> tensor<3x2xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%0 : tensor<2x3xf32>) outs(%1 : tensor<3x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x2xf32>
    %cast = tensor.cast %2 : tensor<3x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


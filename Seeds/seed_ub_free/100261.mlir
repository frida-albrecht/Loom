#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.588800e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-4.414000e+01> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"], library_call = "some_broadcast_external_fn"} ins(%0 : tensor<f32>) outs(%1 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x4xf32>
    %cast = tensor.cast %2 : tensor<3x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


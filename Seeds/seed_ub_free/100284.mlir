#map = affine_map<(d0) -> (0, d0)>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.461100e+02> : tensor<1x5xf32>}> : () -> tensor<1x5xf32>
    %1 = "tosa.const"() <{values = dense<-1.869500e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel"], library_call = "some_external_fn"} ins(%0 : tensor<1x5xf32>) outs(%1 : tensor<5xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<5xf32>
    %cast = tensor.cast %2 : tensor<5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


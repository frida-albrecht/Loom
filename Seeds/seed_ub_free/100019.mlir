#map = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.198000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%0 : tensor<4xf32>) outs(%0 : tensor<4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.exp %in : f32
      linalg.yield %2 : f32
    } -> tensor<4xf32>
    %cast = tensor.cast %1 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


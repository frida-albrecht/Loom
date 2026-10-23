#map = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.426000e+01> : tensor<f32>}> : () -> tensor<f32>
    %expanded = tensor.expand_shape %0 [] output_shape [1] : tensor<f32> into tensor<1xf32>
    %1 = tensor.empty() : tensor<1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%expanded : tensor<1xf32>) outs(%1 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1xf32>
    %cast = tensor.cast %2 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


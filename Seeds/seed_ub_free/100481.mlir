#map = affine_map<() -> ()>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.808000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.688000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tensor.empty() : tensor<f32>
    %3 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%0, %1 : tensor<f32>, tensor<f32>) outs(%2 : tensor<f32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.addf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<f32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


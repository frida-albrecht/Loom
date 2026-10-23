#map = affine_map<() -> ()>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 8.802000e+01 : f32
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%cst : f32) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<f32>
    %cast = tensor.cast %1 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


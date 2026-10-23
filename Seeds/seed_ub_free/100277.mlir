#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.331800e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %cst = arith.constant -93.0299987 : f32
    %1 = tensor.empty() : tensor<4xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel"]} ins(%0, %cst : tensor<4xf32>, f32) outs(%1 : tensor<4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.divf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<4xf32>
    %cast = tensor.cast %2 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.020000e+00> : tensor<1x1x42xf32>}> : () -> tensor<1x1x42xf32>
    %1 = tensor.empty() : tensor<1x1x42xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%0 : tensor<1x1x42xf32>) outs(%1 : tensor<1x1x42xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<1x1x42xf32>
    %cast = tensor.cast %2 : tensor<1x1x42xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


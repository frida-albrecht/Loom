#map = affine_map<(d0, d1, d2, d3) -> (d3, d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.960000e+00> : tensor<41x3x1x57xf32>}> : () -> tensor<41x3x1x57xf32>
    %1 = "tosa.const"() <{values = dense<-1.907000e+01> : tensor<3x1x57x41xf32>}> : () -> tensor<3x1x57x41xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%0 : tensor<41x3x1x57xf32>) outs(%1 : tensor<3x1x57x41xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x1x57x41xf32>
    %cast = tensor.cast %2 : tensor<3x1x57x41xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


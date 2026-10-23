#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.898000e+01> : tensor<2x32x10x4096xf32>}> : () -> tensor<2x32x10x4096xf32>
    %1 = "tosa.const"() <{values = dense<-81.5299987> : tensor<2x32xf32>}> : () -> tensor<2x32xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction", "reduction"]} ins(%0 : tensor<2x32x10x4096xf32>) outs(%1 : tensor<2x32xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<2x32xf32>
    %cast = tensor.cast %2 : tensor<2x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


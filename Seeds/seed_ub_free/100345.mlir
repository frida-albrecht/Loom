#map = affine_map<(d0, d1, d2, d3) -> (d0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.715100e+02> : tensor<10x20x30xf32>}> : () -> tensor<10x20x30xf32>
    %1 = "tosa.const"() <{values = dense<-6.121000e+01> : tensor<30x20x40xf32>}> : () -> tensor<30x20x40xf32>
    %2 = "tosa.const"() <{values = dense<1.689100e+02> : tensor<10x40xf32>}> : () -> tensor<10x40xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction", "reduction"]} ins(%0, %1 : tensor<10x20x30xf32>, tensor<30x20x40xf32>) outs(%2 : tensor<10x40xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.mulf %in, %in_0 : f32
      %5 = arith.addf %out, %4 : f32
      linalg.yield %5 : f32
    } -> tensor<10x40xf32>
    %cast = tensor.cast %3 : tensor<10x40xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


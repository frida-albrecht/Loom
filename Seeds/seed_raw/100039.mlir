#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.473000e+01> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %1 = "tosa.const"() <{values = dense<1.686600e+02> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %2 = "tosa.const"() <{values = dense<-4.480000e+01> : tensor<64x64xf32>}> : () -> tensor<64x64xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%0, %1 : tensor<64x128xf32>, tensor<64x128xf32>) outs(%2 : tensor<64x64xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.mulf %in, %in_0 : f32
      %5 = arith.addf %out, %4 : f32
      linalg.yield %5 : f32
    } -> tensor<64x64xf32>
    %cast = tensor.cast %3 : tensor<64x64xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


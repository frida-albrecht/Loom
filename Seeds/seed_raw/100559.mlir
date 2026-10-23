#map = affine_map<(d0, d1, d2) -> (d2, d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.602500e+02> : tensor<32x2x16xf32>}> : () -> tensor<32x2x16xf32>
    %1 = "tosa.const"() <{values = dense<89.0899963> : tensor<2x16x32xf32>}> : () -> tensor<2x16x32xf32>
    %2 = "tosa.const"() <{values = dense<-8.966000e+01> : tensor<2x16x32xf32>}> : () -> tensor<2x16x32xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%0, %1 : tensor<32x2x16xf32>, tensor<2x16x32xf32>) outs(%2 : tensor<2x16x32xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.divf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<2x16x32xf32>
    %cast = tensor.cast %3 : tensor<2x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


#map = affine_map<(d0, d1, d2, d3) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-87.6699981> : tensor<3x3xf32>}> : () -> tensor<3x3xf32>
    %1 = "tosa.const"() <{values = dense<95> : tensor<4x3xi32>}> : () -> tensor<4x3xi32>
    %2 = "tosa.const"() <{values = dense<-148> : tensor<4x3xi32>}> : () -> tensor<4x3xi32>
    %3 = "tosa.const"() <{values = dense<1.141700e+02> : tensor<4x7x2xf32>}> : () -> tensor<4x7x2xf32>
    %4 = "tosa.const"() <{values = dense<6.416000e+01> : tensor<4x7x3x2xf32>}> : () -> tensor<4x7x3x2xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%1, %2, %3 : tensor<4x3xi32>, tensor<4x3xi32>, tensor<4x7x2xf32>) outs(%4 : tensor<4x7x3x2xf32>) {
    ^bb0(%in: i32, %in_0: i32, %in_1: f32, %out: f32):
      %6 = arith.index_cast %in : i32 to index
      %7 = arith.index_cast %in_0 : i32 to index
      %extracted = tensor.extract %0[%6, %7] : tensor<3x3xf32>
      linalg.yield %extracted : f32
    } -> tensor<4x7x3x2xf32>
    %cast = tensor.cast %5 : tensor<4x7x3x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


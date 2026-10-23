#map = affine_map<(d0, d1, d2, d3) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.423300e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<148> : tensor<4x3xi32>}> : () -> tensor<4x3xi32>
    %2 = "tosa.const"() <{values = dense<-1.733500e+02> : tensor<4x7x3x2xf32>}> : () -> tensor<4x7x3x2xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%1 : tensor<4x3xi32>) outs(%2 : tensor<4x7x3x2xf32>) {
    ^bb0(%in: i32, %out: f32):
      %4 = arith.index_cast %in : i32 to index
      %extracted = tensor.extract %0[%4] : tensor<3xf32>
      linalg.yield %extracted : f32
    } -> tensor<4x7x3x2xf32>
    %cast = tensor.cast %3 : tensor<4x7x3x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


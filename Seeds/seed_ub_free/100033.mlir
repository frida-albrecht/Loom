#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<75.6699981> : tensor<8x16xf32>}> : () -> tensor<8x16xf32>
    %1 = "tosa.const"() <{values = dense<-1.518300e+02> : tensor<16xf32>}> : () -> tensor<16xf32>
    %2 = "tosa.const"() <{values = dense<1.405800e+02> : tensor<16x8xf32>}> : () -> tensor<16x8xf32>
    %3 = linalg.elementwise kind=#linalg.elementwise_kind<add> indexing_maps = [#map, #map1, #map2] ins(%0, %1 : tensor<8x16xf32>, tensor<16xf32>) outs(%2 : tensor<16x8xf32>) -> tensor<16x8xf32>
    %cast = tensor.cast %3 : tensor<16x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


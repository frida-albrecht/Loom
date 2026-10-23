#map = affine_map<(d0, d1, d2) -> (d2, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.380000e+00> : tensor<32x16xf32>}> : () -> tensor<32x16xf32>
    %1 = "tosa.const"() <{values = dense<6.132000e+01> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %2 = linalg.elementwise kind=#linalg.elementwise_kind<tanh> indexing_maps = [#map, #map1] ins(%0 : tensor<32x16xf32>) outs(%1 : tensor<8x16x32xf32>) -> tensor<8x16x32xf32>
    %cast = tensor.cast %2 : tensor<8x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


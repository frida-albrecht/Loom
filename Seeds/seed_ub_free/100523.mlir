#map = affine_map<(d0, d1, d2) -> (d2, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<32x16xi1>}> : () -> tensor<32x16xi1>
    %1 = "tosa.const"() <{values = dense<6.128000e+01> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %2 = "tosa.const"() <{values = dense<-1.556000e+01> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %3 = "tosa.const"() <{values = dense<-65.1699981> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %4 = linalg.elementwise kind=#linalg.elementwise_kind<select> indexing_maps = [#map, #map1, #map1, #map1] ins(%0, %1, %2 : tensor<32x16xi1>, tensor<8x16x32xf32>, tensor<8x16x32xf32>) outs(%3 : tensor<8x16x32xf32>) -> tensor<8x16x32xf32>
    %cast = tensor.cast %4 : tensor<8x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


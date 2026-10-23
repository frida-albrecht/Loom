#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.078130e+00> : tensor<16x8xf16>}> : () -> tensor<16x8xf16>
    %1 = "tosa.const"() <{values = dense<1.200200e+02> : tensor<8x32xf64>}> : () -> tensor<8x32xf64>
    %2 = "tosa.const"() <{values = dense<-1.923100e+02> : tensor<16x32xf32>}> : () -> tensor<16x32xf32>
    %3 = linalg.contract indexing_maps = [#map, #map1, #map2] ins(%0, %1 : tensor<16x8xf16>, tensor<8x32xf64>) outs(%2 : tensor<16x32xf32>) -> tensor<16x32xf32>
    %cast = tensor.cast %3 : tensor<16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0 + d1 + d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.331800e+02> : tensor<8x128x768xf32>}> : () -> tensor<8x128x768xf32>
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %1 = tensor.empty() : tensor<8x1xf32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%1 : tensor<8x1xf32>) {
    ^bb0(%out: f32):
      %3 = linalg.index 0 : index
      %4 = linalg.index 1 : index
      %5 = affine.apply #map1(%c2, %4, %c2)
      %extracted = tensor.extract %0[%3, %c0, %5] : tensor<8x128x768xf32>
      linalg.yield %extracted : f32
    } -> tensor<8x1xf32>
    %cast = tensor.cast %2 : tensor<8x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


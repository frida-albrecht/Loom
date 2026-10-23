#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0 + d1 + d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.338000e+01> : tensor<1x2x3xf32>}> : () -> tensor<1x2x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.681500e+02> : tensor<1x1x3xf32>}> : () -> tensor<1x1x3xf32>
    %c9 = arith.constant 9 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel"]} outs(%1 : tensor<1x1x3xf32>) {
    ^bb0(%out: f32):
      %3 = linalg.index 1 : index
      %4 = linalg.index 0 : index
      %5 = affine.apply #map1(%3, %4, %c9)
      %6 = linalg.index 2 : index
      %7 = arith.subi %c2, %6 : index
      %extracted = tensor.extract %0[%c0, %5, %7] : tensor<1x2x3xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x1x3xf32>
    %cast = tensor.cast %2 : tensor<1x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


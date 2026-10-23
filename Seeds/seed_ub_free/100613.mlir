#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0 + d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.883000e+01> : tensor<80x16xf32>}> : () -> tensor<80x16xf32>
    %c8 = arith.constant 8 : index
    %1 = "tosa.const"() <{values = dense<92.1399993> : tensor<1x4xf32>}> : () -> tensor<1x4xf32>
    %c79 = arith.constant 79 : index
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%1 : tensor<1x4xf32>) {
    ^bb0(%out: f32):
      %3 = linalg.index 1 : index
      %4 = affine.apply #map1(%3, %c8)
      %extracted = tensor.extract %0[%c79, %4] : tensor<80x16xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x4xf32>
    %cast = tensor.cast %2 : tensor<1x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


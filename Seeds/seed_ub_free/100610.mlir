#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.727000e+02> : tensor<3x3x3xf32>}> : () -> tensor<3x3x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.662100e+02> : tensor<1x1x3xf32>}> : () -> tensor<1x1x3xf32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel"]} outs(%1 : tensor<1x1x3xf32>) {
    ^bb0(%out: f32):
      %3 = linalg.index 0 : index
      %4 = linalg.index 1 : index
      %5 = linalg.index 2 : index
      %extracted = tensor.extract %0[%3, %4, %5] : tensor<3x3x3xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x1x3xf32>
    %cast = tensor.cast %2 : tensor<1x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


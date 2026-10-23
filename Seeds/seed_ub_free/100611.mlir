#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.531000e+01> : tensor<3x3x3xf32>}> : () -> tensor<3x3x3xf32>
    %1 = "tosa.const"() <{values = dense<-3.100000e+01> : tensor<3x1x1xf32>}> : () -> tensor<3x1x1xf32>
    %c0 = arith.constant 0 : index
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel"]} outs(%1 : tensor<3x1x1xf32>) {
    ^bb0(%out: f32):
      %extracted = tensor.extract %0[%c0, %c0, %c0] : tensor<3x3x3xf32>
      linalg.yield %extracted : f32
    } -> tensor<3x1x1xf32>
    %cast = tensor.cast %2 : tensor<3x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89.1999969> : tensor<3x3xf32>}> : () -> tensor<3x3xf32>
    %1 = "tosa.const"() <{values = dense<6.099000e+01> : tensor<1x1x3xf32>}> : () -> tensor<1x1x3xf32>
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel"]} outs(%1 : tensor<1x1x3xf32>) {
    ^bb0(%out: f32):
      %extracted = tensor.extract %0[%c1, %c2] : tensor<3x3xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x1x3xf32>
    %cast = tensor.cast %2 : tensor<1x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


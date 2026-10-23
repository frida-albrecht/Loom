#map = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.095400e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-3.388000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%1 : tensor<1xf32>) {
    ^bb0(%out: f32):
      %extracted = tensor.extract %0[] : tensor<f32>
      linalg.yield %extracted : f32
    } -> tensor<1xf32>
    %cast = tensor.cast %2 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


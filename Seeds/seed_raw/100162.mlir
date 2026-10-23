#map = affine_map<() -> ()>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.385000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.700900e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = []} outs(%1 : tensor<f32>) {
    ^bb0(%out: f32):
      %extracted = tensor.extract %0[] : tensor<f32>
      linalg.yield %extracted : f32
    } -> tensor<f32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


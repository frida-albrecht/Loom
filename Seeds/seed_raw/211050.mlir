module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.788000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.clamp %0 {max_val = 7.700000e+01 : f32, min_val = 0.000000e+00 : f32} : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %1 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


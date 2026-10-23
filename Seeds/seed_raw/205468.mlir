module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.740000e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-9.816000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %3 = tosa.abs %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


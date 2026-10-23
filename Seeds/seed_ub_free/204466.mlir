module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.913000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-1.174300e+02> : tensor<f32>}> : () -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %v0 = tosa.maximum %0, %c0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %v1 = tosa.maximum %1, %c1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %2 = tosa.pow %v0, %v1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %3 = tosa.rsqrt %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
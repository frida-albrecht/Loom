module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.753300e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.floor %0 : (tensor<f32>) -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %p1 = tosa.maximum %1, %c0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %p2 = tosa.maximum %1, %c1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %2 = tosa.pow %p1, %p2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
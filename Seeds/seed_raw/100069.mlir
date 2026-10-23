module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.688800e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<-8.938000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = linalg.dot ins(%0, %0 : tensor<4xf32>, tensor<4xf32>) outs(%1 : tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


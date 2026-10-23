module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.519900e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.negate %1, %2, %3 : (tensor<f32>, tensor<1xf32>, tensor<1xf32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


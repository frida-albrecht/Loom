module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.976900e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %2 = tosa.tanh %1 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.sigmoid %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


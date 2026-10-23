module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.524300e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.sigmoid %0 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %1 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


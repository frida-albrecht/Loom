module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.047000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %1, %2 : (tensor<f32>, !tosa.shape<2>) -> tensor<1x1xf32>
    %cast = tensor.cast %3 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


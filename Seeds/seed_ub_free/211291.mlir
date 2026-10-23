module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.415000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<f32>, !tosa.shape<2>) -> tensor<1x1xf32>
    %cast = tensor.cast %2 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


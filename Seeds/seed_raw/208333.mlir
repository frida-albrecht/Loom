module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.864100e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.sigmoid %0 : (tensor<f32>) -> tensor<f32>
    %2 = tosa.identity %1 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.sub %2, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.reshape %3, %4 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %6 = tosa.log %5 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %6 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.628200e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<8.399000e+01> : tensor<f32>}> : () -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %clamped0 = tosa.maximum %0, %c0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %2 = tosa.pow %clamped0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %3 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<f32>, !tosa.shape<3>) -> tensor<1x1x1xf32>
    %5 = tosa.add %4, %4 : (tensor<1x1x1xf32>, tensor<1x1x1xf32>) -> tensor<1x1x1xf32>
    %6 = tosa.reduce_sum %5 {axis = 1 : i32} : (tensor<1x1x1xf32>) -> tensor<1x1x1xf32>
    %7 = tosa.const_shape  {values = dense<[3, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %8 = tosa.tile %6, %7 : (tensor<1x1x1xf32>, !tosa.shape<3>) -> tensor<3x3x1xf32>
    %cast = tensor.cast %8 : tensor<3x3x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
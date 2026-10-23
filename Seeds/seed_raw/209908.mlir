module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.853100e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = tosa.clamp %0 {max_val = 6.900000e+01 : f32, min_val = 5.700000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %2 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.reshape %3, %4 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %6 = tosa.log %5 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %7 = tosa.floor %6 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %8 = tosa.rsqrt %7 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %9 = tosa.tanh %8 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %9 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


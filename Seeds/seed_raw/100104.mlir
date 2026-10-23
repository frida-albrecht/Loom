module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.256300e+02> : tensor<1x28x28x2x3xf32>}> : () -> tensor<1x28x28x2x3xf32>
    %1 = "tosa.const"() <{values = dense<1.078400e+02> : tensor<2x8x3x3x3xf32>}> : () -> tensor<2x8x3x3x3xf32>
    %2 = "tosa.const"() <{values = dense<-1.334800e+02> : tensor<1x26x26x2x8xf32>}> : () -> tensor<1x26x26x2x8xf32>
    %3 = linalg.conv_2d_nhwgc_gfhwc {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<1x28x28x2x3xf32>, tensor<2x8x3x3x3xf32>) outs(%2 : tensor<1x26x26x2x8xf32>) -> tensor<1x26x26x2x8xf32>
    %cast = tensor.cast %3 : tensor<1x26x26x2x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


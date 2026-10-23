module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.737100e+02> : tensor<1x12x8xf32>}> : () -> tensor<1x12x8xf32>
    %1 = "tosa.const"() <{values = dense<-2.807000e+01> : tensor<3x8x8xf32>}> : () -> tensor<3x8x8xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<1x10x8x8xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x10x8x8xf32>) -> tensor<1x10x8x8xf32>
    %4 = linalg.depthwise_conv_1d_nwc_wcm {dilations = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} ins(%0, %1 : tensor<1x12x8xf32>, tensor<3x8x8xf32>) outs(%3 : tensor<1x10x8x8xf32>) -> tensor<1x10x8x8xf32>
    %cast = tensor.cast %4 : tensor<1x10x8x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


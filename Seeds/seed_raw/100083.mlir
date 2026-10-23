module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.177200e+02> : tensor<2x1x6x5xf32>}> : () -> tensor<2x1x6x5xf32>
    %1 = "tosa.const"() <{values = dense<1.001900e+02> : tensor<2x1x3x5xf32>}> : () -> tensor<2x1x3x5xf32>
    %2 = "tosa.const"() <{values = dense<4.664000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<-8.685000e+01> : tensor<2x1x4x2xf32>}> : () -> tensor<2x1x4x2xf32>
    %4 = linalg.conv_2d_nhwc_fhwc {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<2x1x6x5xf32>, tensor<2x1x3x5xf32>) outs(%3 : tensor<2x1x4x2xf32>) -> tensor<2x1x4x2xf32>
    %cast = tensor.cast %4 : tensor<2x1x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


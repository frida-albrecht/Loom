module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.821100e+02> : tensor<1x5x3x32x32xf32>}> : () -> tensor<1x5x3x32x32xf32>
    %1 = "tosa.const"() <{values = dense<-3.847000e+01> : tensor<5x2x3x3x3xf32>}> : () -> tensor<5x2x3x3x3xf32>
    %2 = "tosa.const"() <{values = dense<-9.672000e+01> : tensor<1x5x2x30x30xf32>}> : () -> tensor<1x5x2x30x30xf32>
    %3 = linalg.conv_2d_ngchw_gfchw {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<1x5x3x32x32xf32>, tensor<5x2x3x3x3xf32>) outs(%2 : tensor<1x5x2x30x30xf32>) -> tensor<1x5x2x30x30xf32>
    %cast = tensor.cast %3 : tensor<1x5x2x30x30xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


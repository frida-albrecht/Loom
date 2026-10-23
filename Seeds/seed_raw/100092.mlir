module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.065000e+02> : tensor<2x6x6x5xf16>}> : () -> tensor<2x6x6x5xf16>
    %1 = "tosa.const"() <{values = dense<-9.612500e+01> : tensor<2x3x3x5xf16>}> : () -> tensor<2x3x3x5xf16>
    %2 = "tosa.const"() <{values = dense<1.873800e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<-1.776000e+01> : tensor<2x4x4x2xf32>}> : () -> tensor<2x4x4x2xf32>
    %4 = linalg.conv_2d_nhwc_fhwc {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<2x6x6x5xf16>, tensor<2x3x3x5xf16>) outs(%3 : tensor<2x4x4x2xf32>) -> tensor<2x4x4x2xf32>
    %cast = tensor.cast %4 : tensor<2x4x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.960000e+00> : tensor<2x7x7x5xf32>}> : () -> tensor<2x7x7x5xf32>
    %1 = "tosa.const"() <{values = dense<-7.891000e+01> : tensor<2x4x4x5xf32>}> : () -> tensor<2x4x4x5xf32>
    %2 = "tosa.const"() <{values = dense<6.382000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<-1.324000e+01> : tensor<2x4x4x2xf32>}> : () -> tensor<2x4x4x2xf32>
    %4 = linalg.conv_2d_nhwc_fhwc {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<2x7x7x5xf32>, tensor<2x4x4x5xf32>) outs(%3 : tensor<2x4x4x2xf32>) -> tensor<2x4x4x2xf32>
    %cast = tensor.cast %4 : tensor<2x4x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


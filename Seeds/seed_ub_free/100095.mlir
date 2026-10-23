module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.824500e+02> : tensor<2x6x5x5xf32>}> : () -> tensor<2x6x5x5xf32>
    %1 = "tosa.const"() <{values = dense<72.7799987> : tensor<2x3x2x5xf32>}> : () -> tensor<2x3x2x5xf32>
    %2 = "tosa.const"() <{values = dense<1.196000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<-1.655000e+02> : tensor<2x4x4x2xf32>}> : () -> tensor<2x4x4x2xf32>
    %4 = linalg.conv_2d_nhwc_fhwc {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<2x6x5x5xf32>, tensor<2x3x2x5xf32>) outs(%3 : tensor<2x4x4x2xf32>) -> tensor<2x4x4x2xf32>
    %cast = tensor.cast %4 : tensor<2x4x4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

以上是mlir测试用例，从中分析所有的opname， 他们以XX.XX的形式出现，例如tosa.const，linalg.conv_2d_nhwc_fhwc 用python实现

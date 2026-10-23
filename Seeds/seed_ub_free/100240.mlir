module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.572200e+02> : tensor<1x4x16x1xf32>}> : () -> tensor<1x4x16x1xf32>
    %1 = "tosa.const"() <{values = dense<-75.5899963> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %2 = "tosa.const"() <{values = dense<1.730100e+02> : tensor<1x2x4x1xf32>}> : () -> tensor<1x2x4x1xf32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<[1, 2]> : tensor<2xi64>, strides = dense<[2, 4]> : tensor<2xi64>} ins(%0, %1 : tensor<1x4x16x1xf32>, tensor<2x2xf32>) outs(%2 : tensor<1x2x4x1xf32>) -> tensor<1x2x4x1xf32>
    %cast = tensor.cast %3 : tensor<1x2x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


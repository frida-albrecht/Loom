module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.693000e+01> : tensor<1x16x1xf32>}> : () -> tensor<1x16x1xf32>
    %1 = "tosa.const"() <{values = dense<-1.988200e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = "tosa.const"() <{values = dense<1.084200e+02> : tensor<1x4x1xf32>}> : () -> tensor<1x4x1xf32>
    %3 = linalg.pooling_nwc_sum {dilations = dense<2> : tensor<1xi64>, strides = dense<4> : tensor<1xi64>} ins(%0, %1 : tensor<1x16x1xf32>, tensor<2xf32>) outs(%2 : tensor<1x4x1xf32>) -> tensor<1x4x1xf32>
    %cast = tensor.cast %3 : tensor<1x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


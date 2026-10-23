module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.080000e+01> : tensor<2x6x6x13x12xf32>}> : () -> tensor<2x6x6x13x12xf32>
    %1 = "tosa.const"() <{values = dense<-4.716000e+01> : tensor<6x2x1x3xf32>}> : () -> tensor<6x2x1x3xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = tensor.empty() : tensor<2x6x3x13x4xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<2x6x3x13x4xf32>) -> tensor<2x6x3x13x4xf32>
    %4 = linalg.depthwise_conv_3d_ncdhw_cdhw {dilations = dense<1> : tensor<3xi64>, strides = dense<[2, 1, 3]> : tensor<3xi64>} ins(%0, %1 : tensor<2x6x6x13x12xf32>, tensor<6x2x1x3xf32>) outs(%3 : tensor<2x6x3x13x4xf32>) -> tensor<2x6x3x13x4xf32>
    %cast = tensor.cast %4 : tensor<2x6x3x13x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


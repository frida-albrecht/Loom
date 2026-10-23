module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.726400e+02> : tensor<1x1x4x4xf32>}> : () -> tensor<1x1x4x4xf32>
    %1 = tensor.empty() : tensor<3x3xf32>
    %2 = tensor.empty() : tensor<1x1x2x2xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x1x2x2xf32>) -> tensor<1x1x2x2xf32>
    %4 = linalg.pooling_nchw_sum {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<1x1x4x4xf32>, tensor<3x3xf32>) outs(%3 : tensor<1x1x2x2xf32>) -> tensor<1x1x2x2xf32>
    %cast = tensor.cast %4 : tensor<1x1x2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


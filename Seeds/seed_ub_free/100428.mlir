module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<89.4199981> : tensor<1x4x4x4x1xf32>}> : () -> tensor<1x4x4x4x1xf32>
    %1 = tensor.empty() : tensor<3x3x3xf32>
    %2 = tensor.empty() : tensor<1x2x2x2x1xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x2x2x2x1xf32>) -> tensor<1x2x2x2x1xf32>
    %4 = linalg.pooling_ndhwc_sum {dilations = dense<1> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} ins(%0, %1 : tensor<1x4x4x4x1xf32>, tensor<3x3x3xf32>) outs(%3 : tensor<1x2x2x2x1xf32>) -> tensor<1x2x2x2x1xf32>
    %cast = tensor.cast %4 : tensor<1x2x2x2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


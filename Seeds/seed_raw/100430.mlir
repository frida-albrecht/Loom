module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-170> : tensor<1x4x4x1xi32>}> : () -> tensor<1x4x4x1xi32>
    %1 = tensor.empty() : tensor<3x3xi32>
    %2 = tensor.empty() : tensor<1x2x2x1xi32>
    %c0_i32 = arith.constant 0 : i32
    %3 = linalg.fill ins(%c0_i32 : i32) outs(%2 : tensor<1x2x2x1xi32>) -> tensor<1x2x2x1xi32>
    %4 = linalg.pooling_nhwc_max {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<1x4x4x1xi32>, tensor<3x3xi32>) outs(%3 : tensor<1x2x2x1xi32>) -> tensor<1x2x2x1xi32>
    %cast = tensor.cast %4 : tensor<1x2x2x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


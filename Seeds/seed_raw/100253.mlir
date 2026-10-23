module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<112> : tensor<1x16x1xi32>}> : () -> tensor<1x16x1xi32>
    %1 = "tosa.const"() <{values = dense<153> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = "tosa.const"() <{values = dense<118> : tensor<1x4x1xi32>}> : () -> tensor<1x4x1xi32>
    %3 = linalg.pooling_nwc_min_unsigned {dilations = dense<2> : tensor<1xi64>, strides = dense<4> : tensor<1xi64>} ins(%0, %1 : tensor<1x16x1xi32>, tensor<2xi32>) outs(%2 : tensor<1x4x1xi32>) -> tensor<1x4x1xi32>
    %cast = tensor.cast %3 : tensor<1x4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


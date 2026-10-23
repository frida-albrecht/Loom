module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<63> : tensor<1x16x1xi32>}> : () -> tensor<1x16x1xi32>
    %1 = "tosa.const"() <{values = dense<-79> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = "tosa.const"() <{values = dense<-51> : tensor<1x4x1xi32>}> : () -> tensor<1x4x1xi32>
    %3 = linalg.pooling_nwc_max_unsigned {dilations = dense<2> : tensor<1xi64>, strides = dense<4> : tensor<1xi64>} ins(%0, %1 : tensor<1x16x1xi32>, tensor<2xi32>) outs(%2 : tensor<1x4x1xi32>) -> tensor<1x4x1xi32>
    %cast = tensor.cast %3 : tensor<1x4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


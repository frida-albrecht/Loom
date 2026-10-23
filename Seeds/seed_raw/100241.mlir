module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-40> : tensor<1x4x16x1xi32>}> : () -> tensor<1x4x16x1xi32>
    %1 = "tosa.const"() <{values = dense<181> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %2 = "tosa.const"() <{values = dense<-108> : tensor<1x2x4x1xi32>}> : () -> tensor<1x2x4x1xi32>
    %3 = linalg.pooling_nhwc_max {dilations = dense<[1, 2]> : tensor<2xi64>, strides = dense<[2, 4]> : tensor<2xi64>} ins(%0, %1 : tensor<1x4x16x1xi32>, tensor<2x2xi32>) outs(%2 : tensor<1x2x4x1xi32>) -> tensor<1x2x4x1xi32>
    %cast = tensor.cast %3 : tensor<1x2x4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


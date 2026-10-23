module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-77> : tensor<7x7x8xi32>}> : () -> tensor<7x7x8xi32>
    %1 = "tosa.const"() <{values = dense<84> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %s0 = tosa.maximum %1, %c0 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %s1 = tosa.minimum %s0, %c31 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %2 = tosa.logical_right_shift %0, %s1 : (tensor<7x7x8xi32>, tensor<1x1x8xi32>) -> tensor<7x7x8xi32>
    %cast = tensor.cast %2 : tensor<7x7x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
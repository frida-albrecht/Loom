module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<111> : tensor<4x9x8xi32>}> : () -> tensor<4x9x8xi32>
    %1 = "tosa.const"() <{values = dense<-163> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %2 = tosa.bitwise_or %0, %1 : (tensor<4x9x8xi32>, tensor<1x1x8xi32>) -> tensor<4x9x8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x9x8xi32>}> : () -> tensor<4x9x8xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<4x9x8xi32>}> : () -> tensor<4x9x8xi32>
    %l1 = tosa.maximum %2, %c0 : (tensor<4x9x8xi32>, tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %l2 = tosa.minimum %l1, %c31 : (tensor<4x9x8xi32>, tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %3 = tosa.logical_left_shift %2, %l2 : (tensor<4x9x8xi32>, tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %cast = tensor.cast %3 : tensor<4x9x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
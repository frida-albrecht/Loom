module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-170> : tensor<3x4x3x3xi32>}> : () -> tensor<3x4x3x3xi32>
    %1 = tosa.bitwise_not %0 : (tensor<3x4x3x3xi32>) -> tensor<3x4x3x3xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x4x3x3xi32>}> : () -> tensor<3x4x3x3xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<3x4x3x3xi32>}> : () -> tensor<3x4x3x3xi32>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<3x4x3x3xi32>, tensor<3x4x3x3xi32>) -> tensor<3x4x3x3xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<3x4x3x3xi32>, tensor<3x4x3x3xi32>) -> tensor<3x4x3x3xi32>
    %2 = tosa.arithmetic_right_shift %1, %clamped_shift {round = true} : (tensor<3x4x3x3xi32>, tensor<3x4x3x3xi32>) -> tensor<3x4x3x3xi32>
    %cast = tensor.cast %2 : tensor<3x4x3x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
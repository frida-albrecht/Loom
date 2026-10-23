module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-183> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %1 = "tosa.const"() <{values = dense<-123> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<6x1xi32>, tensor<6x1xi32>) -> tensor<6x1xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %clamped_lower = tosa.maximum %2, %c0 : (tensor<6x1xi32>, tensor<6x1xi32>) -> tensor<6x1xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<6x1xi32>, tensor<6x1xi32>) -> tensor<6x1xi32>
    %3 = tosa.arithmetic_right_shift %2, %clamped_shift {round = true} : (tensor<6x1xi32>, tensor<6x1xi32>) -> tensor<6x1xi32>
    %cast = tensor.cast %3 : tensor<6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
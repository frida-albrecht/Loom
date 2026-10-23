module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-191> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<3xi32>) -> tensor<1xi32>
    // UB fix for tosa.arithmetic_right_shift: operand %1 (shift amount) must be in range [0, 31] for i32.
    // Insert clamping operations to ensure the shift amount is within the valid range.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1xi32>}> : () -> tensor<1xi32>
    %a1 = tosa.maximum %1, %c0 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %a2 = tosa.minimum %a1, %c31 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %2 = tosa.arithmetic_right_shift %1, %a2 {round = true} : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.bitwise_or %2, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.sub %4, %4 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.transpose %5 {perms = array<i32: 0>} : (tensor<1xi32>) -> tensor<1xi32>
    %8 = tosa.minimum %7, %4 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %8 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
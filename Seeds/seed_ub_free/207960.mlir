module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<2x4x9x5xi8>}> : () -> tensor<2x4x9x5xi8>
    %1 = "tosa.const"() <{values = dense<-4> : tensor<1x4x1x5xi8>}> : () -> tensor<1x4x1x5xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<2x4x9x5xi8>, tensor<1x4x1x5xi8>) -> tensor<2x4x9x5xi8>
    // Output Inference: %2 contains elements with value -3 (00001101 | 11111100 = 11111101, which is -3 in 8-bit two's complement).
    // Undefined Behavior Detection for tosa.logical_left_shift:
    // The second operand (%2) is used as the shift amount. Its elements are -3.
    // For i8, the shift amount must be in the range [0, 7]. -3 is outside this range.
    // Fix: Clamp the shift amount to [0, 7].
    %a0 = "tosa.const"() <{values = dense<0> : tensor<2x4x9x5xi8>}> : () -> tensor<2x4x9x5xi8>
    %a1 = "tosa.const"() <{values = dense<7> : tensor<2x4x9x5xi8>}> : () -> tensor<2x4x9x5xi8>
    %a2 = tosa.maximum %2, %a0 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %a3 = tosa.minimum %a2, %a1 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %3 = tosa.logical_left_shift %2, %a3 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    // Re-evaluation for %3: lhs is %2 (-3), rhs is %a3 (clamped to 0).
    // So %3 elements are (-3) << 0 = -3.
    // Undefined Behavior Detection for tosa.arithmetic_right_shift:
    // The second operand (%3) is used as the shift amount. Its elements are -3.
    // For i8, the shift amount must be in the range [0, 7]. -3 is outside this range.
    // Fix: Clamp the shift amount to [0, 7]. Reusing constants %a0 and %a1.
    %a4 = tosa.maximum %3, %a0 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %a5 = tosa.minimum %a4, %a1 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %4 = tosa.arithmetic_right_shift %3, %a5 {round = false} : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    // Re-evaluation for %4: lhs is %3 (-3), rhs is %a5 (clamped to 0).
    // So %4 elements are (-3) >> 0 = -3.
    %5 = tosa.concat %4, %4 {axis = 0 : i32} : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<4x4x9x5xi8>
    %cast = tensor.cast %5 : tensor<4x4x9x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
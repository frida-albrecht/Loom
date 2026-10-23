module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<7x8x3x2xi8>}> : () -> tensor<7x8x3x2xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<7x1x1x1xi8>}> : () -> tensor<7x1x1x1xi8>
    // Undefined behavior detected for tosa.logical_left_shift:
    // For i8 type, the shift amount (operand 2) must be in the range [0, 7].
    // The value of %1 is 9, which violates the upper bound (9 > 7).
    // Fix: Clamp the shift amount to the maximum allowed value (7) using tosa.minimum.
    // The constant for clamping must have the same shape and type as %1 to satisfy hard constraint 4.1.
    %c7 = "tosa.const"() <{values = dense<7> : tensor<7x1x1x1xi8>}> : () -> tensor<7x1x1x1xi8>
    %l1 = tosa.minimum %1, %c7 : (tensor<7x1x1x1xi8>, tensor<7x1x1x1xi8>) -> tensor<7x1x1x1xi8>
    %2 = tosa.logical_left_shift %0, %l1 : (tensor<7x8x3x2xi8>, tensor<7x1x1x1xi8>) -> tensor<7x8x3x2xi8>
    %3 = tosa.sub %2, %2 : (tensor<7x8x3x2xi8>, tensor<7x8x3x2xi8>) -> tensor<7x8x3x2xi8>
    %cast = tensor.cast %3 : tensor<7x8x3x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
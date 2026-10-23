module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<6x8x7xi8>}> : () -> tensor<6x8x7xi8>
    %1 = "tosa.const"() <{values = dense<4> : tensor<6x8x1xi8>}> : () -> tensor<6x8x1xi8>
    // Fix for 'tosa.minimum': Operands must have identical shapes. '%1' (tensor<6x8x1xi8>) needs to be broadcast to match '%0' (tensor<6x8x7xi8>).
    // A new constant with the correct shape and value is created.
    %c0 = "tosa.const"() <{values = dense<4> : tensor<6x8x7xi8>}> : () -> tensor<6x8x7xi8>
    %2 = tosa.minimum %0, %c0 : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    // Output of %2 is tensor<6x8x7xi8> with all elements equal to -9 (minimum of -9 and 4).
    // Fix for 'tosa.arithmetic_right_shift': The second operand (shift amount) must be within [0, 7] for i8.
    // The current value of %2 is -9, which violates this constraint.
    // Clamping operations are inserted to ensure the shift amount is within the valid range.
    %c1 = "tosa.const"() <{values = dense<0> : tensor<6x8x7xi8>}> : () -> tensor<6x8x7xi8>
    %c2 = "tosa.const"() <{values = dense<7> : tensor<6x8x7xi8>}> : () -> tensor<6x8x7xi8>
    %t0 = tosa.maximum %2, %c1 : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %t1 = tosa.minimum %t0, %c2 : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %3 = tosa.arithmetic_right_shift %2, %t1 {round = true} : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %4 = tosa.bitwise_and %3, %2 : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %cast = tensor.cast %4 : tensor<6x8x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
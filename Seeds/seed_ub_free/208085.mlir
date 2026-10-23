module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-26> : tensor<2xi16>}> : () -> tensor<2xi16>
    %1 = "tosa.const"() <{values = dense<142> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = "tosa.const"() <{values = dense<8> : tensor<3x10xi8>}> : () -> tensor<3x10xi8>
    %3 = "tosa.const"() <{values = dense<9> : tensor<1x10xi8>}> : () -> tensor<1x10xi8>
    %4 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.pad %0, %4, %5 : (tensor<2xi16>, !tosa.shape<2>, tensor<1xi16>) -> tensor<2xi16>
    // tosa.minimum: Hard Constraint Violation - operands must have identical rank, shape, and element dtype.
    // %2 is tensor<3x10xi8>, %3 is tensor<1x10xi8>.
    // Fix: Create a new constant with the broadcasted shape (tensor<3x10xi8>) for the second operand.
    %c0 = "tosa.const"() <{values = dense<9> : tensor<3x10xi8>}> : () -> tensor<3x10xi8>
    %7 = tosa.minimum %2, %c0 : (tensor<3x10xi8>, tensor<3x10xi8>) -> tensor<3x10xi8>
    // tosa.arithmetic_right_shift: Undefined behavior - shift amount for i16 must be in range [0, 15].
    // %6 values are dense<-26>. These need to be clamped.
    // Fix: Clamp the shift amount using tosa.maximum and tosa.minimum.
    %c1 = "tosa.const"() <{values = dense<0> : tensor<2xi16>}> : () -> tensor<2xi16>
    %t0 = tosa.maximum %6, %c1 : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %c2 = "tosa.const"() <{values = dense<15> : tensor<2xi16>}> : () -> tensor<2xi16>
    %t1 = tosa.minimum %t0, %c2 : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %8 = tosa.arithmetic_right_shift %6, %t1 {round = false} : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %7 : tensor<3x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}
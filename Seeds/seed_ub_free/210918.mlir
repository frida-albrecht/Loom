module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.904800e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<200> : tensor<9x3xi16>}> : () -> tensor<9x3xi16>
    %2 = "tosa.const"() <{values = dense<-96> : tensor<9x1xi16>}> : () -> tensor<9x1xi16>
    %3 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    // Undefined Behavior: tosa.arithmetic_right_shift
    // Requirement for i16: 0 <= value2 (shift amount) <= 15.
    // Input value2 from %2 is dense<-96> : tensor<9x1xi16>, which violates 0 <= value2.
    // Fix: Clamp the shift amount to be within [0, 15].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x1xi16>}> : () -> tensor<9x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<9x1xi16>}> : () -> tensor<9x1xi16>
    %a0 = tosa.maximum %2, %c0 : (tensor<9x1xi16>, tensor<9x1xi16>) -> tensor<9x1xi16>
    %a1 = tosa.minimum %a0, %c15 : (tensor<9x1xi16>, tensor<9x1xi16>) -> tensor<9x1xi16>
    %4 = tosa.arithmetic_right_shift %1, %a1 {round = true} : (tensor<9x3xi16>, tensor<9x1xi16>) -> tensor<9x3xi16>
    %5 = tosa.reverse %4 {axis = 1 : i32} : (tensor<9x3xi16>) -> tensor<9x3xi16>
    %6 = tosa.bitwise_or %5, %4 : (tensor<9x3xi16>, tensor<9x3xi16>) -> tensor<9x3xi16>
    %7 = tosa.bitwise_and %6, %5 : (tensor<9x3xi16>, tensor<9x3xi16>) -> tensor<9x3xi16>
    %8 = tosa.const_shape  {values = dense<27> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.reshape %7, %8 : (tensor<9x3xi16>, !tosa.shape<1>) -> tensor<27xi16>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<27xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}
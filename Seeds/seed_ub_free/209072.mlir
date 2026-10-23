module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<53> : tensor<4x6x2x5xi16>}> : () -> tensor<4x6x2x5xi16>
    %1 = "tosa.const"() <{values = dense<40> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<4x6x2x5xi16>, !tosa.shape<8>, tensor<1xi16>) -> tensor<4x6x2x5xi16>
    %5 = tosa.bitwise_xor %4, %4 : (tensor<4x6x2x5xi16>, tensor<4x6x2x5xi16>) -> tensor<4x6x2x5xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x6x2x5xi16>}> : () -> tensor<4x6x2x5xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<4x6x2x5xi16>}> : () -> tensor<4x6x2x5xi16>
    %a0 = tosa.maximum %4, %c0 : (tensor<4x6x2x5xi16>, tensor<4x6x2x5xi16>) -> tensor<4x6x2x5xi16>
    %a1 = tosa.minimum %a0, %c15 : (tensor<4x6x2x5xi16>, tensor<4x6x2x5xi16>) -> tensor<4x6x2x5xi16>
    %6 = tosa.arithmetic_right_shift %5, %a1 {round = false} : (tensor<4x6x2x5xi16>, tensor<4x6x2x5xi16>) -> tensor<4x6x2x5xi16>
    %7 = tosa.sub %6, %5 : (tensor<4x6x2x5xi16>, tensor<4x6x2x5xi16>) -> tensor<4x6x2x5xi16>
    %8 = tosa.const_shape  {values = dense<[2, 8, 15]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %9 = tosa.reshape %7, %8 : (tensor<4x6x2x5xi16>, !tosa.shape<3>) -> tensor<2x8x15xi16>
    %cast = tensor.cast %9 : tensor<2x8x15xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
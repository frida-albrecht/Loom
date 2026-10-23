module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-127> : tensor<2x1x3xi16>}> : () -> tensor<2x1x3xi16>
    %1 = tosa.bitwise_not %0 : (tensor<2x1x3xi16>) -> tensor<2x1x3xi16>
    %2 = tosa.arithmetic_right_shift %1, %1 {round = false} : (tensor<2x1x3xi16>, tensor<2x1x3xi16>) -> tensor<2x1x3xi16>
    %3 = tosa.const_shape  {values = dense<[1, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.tile %2, %3 : (tensor<2x1x3xi16>, !tosa.shape<3>) -> tensor<2x3x6xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %7 = tosa.negate %4, %5, %6 : (tensor<2x3x6xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<2x3x6xi16>
    %cast = tensor.cast %7 : tensor<2x3x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


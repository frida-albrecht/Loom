module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<199> : tensor<10x9x6x6xi16>}> : () -> tensor<10x9x6x6xi16>
    %1 = "tosa.const"() <{values = dense<16> : tensor<1x9x1x6xi16>}> : () -> tensor<1x9x1x6xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<10x9x6x6xi16>, tensor<1x9x1x6xi16>) -> tensor<10x9x6x6xi16>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<10x9x6x6xi16>, tensor<10x9x6x6xi16>) -> tensor<10x9x6x6xi16>
    %4 = tosa.const_shape  {values = dense<[3, 1, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.tile %3, %4 : (tensor<10x9x6x6xi16>, !tosa.shape<4>) -> tensor<30x9x6x12xi16>
    %6 = tosa.abs %5 : (tensor<30x9x6x12xi16>) -> tensor<30x9x6x12xi16>
    %cast = tensor.cast %6 : tensor<30x9x6x12xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


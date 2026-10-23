module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<79> : tensor<3x5xi16>}> : () -> tensor<3x5xi16>
    %1 = "tosa.const"() <{values = dense<-179> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<3x5xi16>, tensor<1x1xi16>) -> tensor<3x5xi16>
    %3 = tosa.const_shape  {values = dense<[1, 5, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<3x5xi16>, !tosa.shape<4>) -> tensor<1x5x1x3xi16>
    %5 = tosa.identity %4 : (tensor<1x5x1x3xi16>) -> tensor<1x5x1x3xi16>
    %6 = tosa.bitwise_not %5 : (tensor<1x5x1x3xi16>) -> tensor<1x5x1x3xi16>
    %cast = tensor.cast %6 : tensor<1x5x1x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


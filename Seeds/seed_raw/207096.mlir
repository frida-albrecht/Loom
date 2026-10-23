module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<73> : tensor<4x7xi16>}> : () -> tensor<4x7xi16>
    %1 = "tosa.const"() <{values = dense<74> : tensor<4x1xi16>}> : () -> tensor<4x1xi16>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<4x7xi16>, tensor<4x1xi16>) -> tensor<4x7xi16>
    %3 = tosa.bitwise_and %2, %2 : (tensor<4x7xi16>, tensor<4x7xi16>) -> tensor<4x7xi16>
    %4 = tosa.bitwise_or %3, %3 : (tensor<4x7xi16>, tensor<4x7xi16>) -> tensor<4x7xi16>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<4x7xi16>) -> tensor<1x7xi16>
    %6 = tosa.logical_left_shift %5, %5 : (tensor<1x7xi16>, tensor<1x7xi16>) -> tensor<1x7xi16>
    %cast = tensor.cast %6 : tensor<1x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


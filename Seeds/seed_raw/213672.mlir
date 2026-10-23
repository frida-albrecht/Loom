module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<135> : tensor<3x10xi16>}> : () -> tensor<3x10xi16>
    %1 = tosa.const_shape  {values = dense<[1, 2, 15, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<3x10xi16>, !tosa.shape<4>) -> tensor<1x2x15x1xi16>
    %3 = tosa.bitwise_and %2, %2 : (tensor<1x2x15x1xi16>, tensor<1x2x15x1xi16>) -> tensor<1x2x15x1xi16>
    %4 = tosa.bitwise_or %3, %3 : (tensor<1x2x15x1xi16>, tensor<1x2x15x1xi16>) -> tensor<1x2x15x1xi16>
    %5 = tosa.reverse %4 {axis = 2 : i32} : (tensor<1x2x15x1xi16>) -> tensor<1x2x15x1xi16>
    %6 = tosa.reduce_min %5 {axis = 2 : i32} : (tensor<1x2x15x1xi16>) -> tensor<1x2x1x1xi16>
    %7 = tosa.reduce_max %6 {axis = 1 : i32} : (tensor<1x2x1x1xi16>) -> tensor<1x1x1x1xi16>
    %8 = tosa.logical_right_shift %7, %7 : (tensor<1x1x1x1xi16>, tensor<1x1x1x1xi16>) -> tensor<1x1x1x1xi16>
    %9 = tosa.abs %8 : (tensor<1x1x1x1xi16>) -> tensor<1x1x1x1xi16>
    %cast = tensor.cast %9 : tensor<1x1x1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


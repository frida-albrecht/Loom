module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<150> : tensor<3x1xi16>}> : () -> tensor<3x1xi16>
    %1 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<3x1xi16>) -> tensor<3x1xi16>
    %2 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %1, %2 : (tensor<3x1xi16>, !tosa.shape<2>) -> tensor<6x3xi16>
    %4 = tosa.sub %3, %3 : (tensor<6x3xi16>, tensor<6x3xi16>) -> tensor<6x3xi16>
    %cast = tensor.cast %4 : tensor<6x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


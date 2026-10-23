module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<71> : tensor<3x3xi16>}> : () -> tensor<3x3xi16>
    %1 = "tosa.const"() <{values = dense<135> : tensor<1x3xi16>}> : () -> tensor<1x3xi16>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<3x3xi16>, tensor<1x3xi16>) -> tensor<3x3xi16>
    %cast = tensor.cast %2 : tensor<3x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


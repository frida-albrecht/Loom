module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<71> : tensor<3x9xi16>}> : () -> tensor<3x9xi16>
    %1 = tosa.abs %0 : (tensor<3x9xi16>) -> tensor<3x9xi16>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<3x9xi16>, tensor<3x9xi16>) -> tensor<3x9xi16>
    %cast = tensor.cast %2 : tensor<3x9xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-21> : tensor<4x7x10xi16>}> : () -> tensor<4x7x10xi16>
    %1 = "tosa.const"() <{values = dense<-62> : tensor<4x1x1xi16>}> : () -> tensor<4x1x1xi16>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<4x7x10xi16>, tensor<4x1x1xi16>) -> tensor<4x7x10xi16>
    %cast = tensor.cast %2 : tensor<4x7x10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-153> : tensor<9x8xi16>}> : () -> tensor<9x8xi16>
    %1 = tosa.abs %0 : (tensor<9x8xi16>) -> tensor<9x8xi16>
    %cast = tensor.cast %1 : tensor<9x8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


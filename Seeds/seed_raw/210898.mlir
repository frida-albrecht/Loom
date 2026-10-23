module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-172> : tensor<7x3x3xi16>}> : () -> tensor<7x3x3xi16>
    %1 = "tosa.const"() <{values = dense<-80> : tensor<1x3x1xi16>}> : () -> tensor<1x3x1xi16>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<7x3x3xi16>, tensor<1x3x1xi16>) -> tensor<7x3x3xi16>
    %cast = tensor.cast %2 : tensor<7x3x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


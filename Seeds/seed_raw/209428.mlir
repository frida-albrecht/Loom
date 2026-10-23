module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<77> : tensor<5x2x5xi16>}> : () -> tensor<5x2x5xi16>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<5x1x1xi16>}> : () -> tensor<5x1x1xi16>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<5x2x5xi16>, tensor<5x1x1xi16>) -> tensor<5x2x5xi16>
    %cast = tensor.cast %2 : tensor<5x2x5xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<8xi16>}> : () -> tensor<8xi16>
    %1 = "tosa.const"() <{values = dense<131> : tensor<8xi16>}> : () -> tensor<8xi16>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<8xi16>, tensor<8xi16>) -> tensor<8xi16>
    %cast = tensor.cast %2 : tensor<8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


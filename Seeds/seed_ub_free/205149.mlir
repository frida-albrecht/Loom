module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<8xi16>}> : () -> tensor<8xi16>
    %1 = "tosa.const"() <{values = dense<131> : tensor<8xi16>}> : () -> tensor<8xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8xi16>}> : () -> tensor<8xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<8xi16>}> : () -> tensor<8xi16>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<8xi16>, tensor<8xi16>) -> tensor<8xi16>
    %clamped_shift = tosa.minimum %clamped_lower, %c15 : (tensor<8xi16>, tensor<8xi16>) -> tensor<8xi16>
    %2 = tosa.arithmetic_right_shift %0, %clamped_shift {round = true} : (tensor<8xi16>, tensor<8xi16>) -> tensor<8xi16>
    %cast = tensor.cast %2 : tensor<8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-111> : tensor<3xi16>}> : () -> tensor<3xi16>
    %1 = tosa.clz %0 : (tensor<3xi16>) -> tensor<3xi16>
    %2 = tosa.logical_right_shift %1, %1 : (tensor<3xi16>, tensor<3xi16>) -> tensor<3xi16>
    %3 = tosa.bitwise_not %2 : (tensor<3xi16>) -> tensor<3xi16>
    %cast = tensor.cast %3 : tensor<3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


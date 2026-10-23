module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<177> : tensor<9x2xi16>}> : () -> tensor<9x2xi16>
    %1 = "tosa.const"() <{values = dense<44> : tensor<1x2xi16>}> : () -> tensor<1x2xi16>
    %2 = tosa.bitwise_and %0, %1 : (tensor<9x2xi16>, tensor<1x2xi16>) -> tensor<9x2xi16>
    %3 = tosa.sub %2, %2 : (tensor<9x2xi16>, tensor<9x2xi16>) -> tensor<9x2xi16>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<9x2xi16>, tensor<9x2xi16>) -> tensor<9x2xi16>
    %cast = tensor.cast %4 : tensor<9x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


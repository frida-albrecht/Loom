module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<99> : tensor<7x7x10xi16>}> : () -> tensor<7x7x10xi16>
    %1 = "tosa.const"() <{values = dense<177> : tensor<1x7x1xi16>}> : () -> tensor<1x7x1xi16>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<7x7x10xi16>, tensor<1x7x1xi16>) -> tensor<7x7x10xi16>
    %3 = tosa.bitwise_not %2 : (tensor<7x7x10xi16>) -> tensor<7x7x10xi16>
    %4 = tosa.clz %3 : (tensor<7x7x10xi16>) -> tensor<7x7x10xi16>
    %cast = tensor.cast %4 : tensor<7x7x10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


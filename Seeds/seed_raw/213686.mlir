module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<96> : tensor<2xi16>}> : () -> tensor<2xi16>
    %1 = "tosa.const"() <{values = dense<99> : tensor<2xi16>}> : () -> tensor<2xi16>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %3 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


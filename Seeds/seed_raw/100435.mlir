module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<1x4x1xi16>}> : () -> tensor<1x4x1xi16>
    %1 = tensor.empty() : tensor<3xi16>
    %2 = tensor.empty() : tensor<1x2x1xi16>
    %c0_i16 = arith.constant 0 : i16
    %3 = linalg.fill ins(%c0_i16 : i16) outs(%2 : tensor<1x2x1xi16>) -> tensor<1x2x1xi16>
    %4 = linalg.pooling_nwc_max {dilations = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} ins(%0, %1 : tensor<1x4x1xi16>, tensor<3xi16>) outs(%3 : tensor<1x2x1xi16>) -> tensor<1x2x1xi16>
    %cast = tensor.cast %4 : tensor<1x2x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


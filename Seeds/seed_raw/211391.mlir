module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<187> : tensor<1x8x9x1xi16>}> : () -> tensor<1x8x9x1xi16>
    %1 = "tosa.const"() <{values = dense<181> : tensor<1x8x9x1xi16>}> : () -> tensor<1x8x9x1xi16>
    %2 = tosa.bitwise_and %0, %1 : (tensor<1x8x9x1xi16>, tensor<1x8x9x1xi16>) -> tensor<1x8x9x1xi16>
    %3 = tosa.abs %2 : (tensor<1x8x9x1xi16>) -> tensor<1x8x9x1xi16>
    %cast = tensor.cast %3 : tensor<1x8x9x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<27> : tensor<9x4x9x6xi16>}> : () -> tensor<9x4x9x6xi16>
    %1 = "tosa.const"() <{values = dense<-88> : tensor<9x1x1x1xi16>}> : () -> tensor<9x1x1x1xi16>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<9x4x9x6xi16>, tensor<9x1x1x1xi16>) -> tensor<9x4x9x6xi16>
    %3 = tosa.clamp %2 {max_val = 119 : i16, min_val = -4 : i16} : (tensor<9x4x9x6xi16>) -> tensor<9x4x9x6xi16>
    %cast = tensor.cast %3 : tensor<9x4x9x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


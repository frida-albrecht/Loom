module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<8x4x4xi16>}> : () -> tensor<8x4x4xi16>
    %1 = tosa.clamp %0 {max_val = 103 : i16, min_val = 26 : i16} : (tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %2 = tosa.arithmetic_right_shift %1, %1 {round = false} : (tensor<8x4x4xi16>, tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %cast = tensor.cast %2 : tensor<8x4x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<8x4x4xi16>}> : () -> tensor<8x4x4xi16>
    %1 = tosa.clamp %0 {max_val = 103 : i16, min_val = 26 : i16} : (tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x4x4xi16>}> : () -> tensor<8x4x4xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<8x4x4xi16>}> : () -> tensor<8x4x4xi16>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<8x4x4xi16>, tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %safe_shift = tosa.minimum %clamped_lower, %c15 : (tensor<8x4x4xi16>, tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %2 = tosa.arithmetic_right_shift %1, %safe_shift {round = false} : (tensor<8x4x4xi16>, tensor<8x4x4xi16>) -> tensor<8x4x4xi16>
    %cast = tensor.cast %2 : tensor<8x4x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
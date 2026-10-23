module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<135> : tensor<i16>}> : () -> tensor<i16>
    %1 = tosa.clamp %0 {max_val = 0 : i16, min_val = -12 : i16} : (tensor<i16>) -> tensor<i16>
    %cast = tensor.cast %1 : tensor<i16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


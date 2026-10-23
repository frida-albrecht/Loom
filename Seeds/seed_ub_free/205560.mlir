module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<200> : tensor<4x5xi16>}> : () -> tensor<4x5xi16>
    %1 = tosa.clamp %0 {max_val = 2 : i16, min_val = -13 : i16} : (tensor<4x5xi16>) -> tensor<4x5xi16>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<4x5xi16>, tensor<4x5xi16>) -> tensor<4x5xi16>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<4x5xi16>) -> tensor<1x5xi16>
    %cast = tensor.cast %3 : tensor<1x5xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


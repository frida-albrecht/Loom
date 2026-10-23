module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<189> : tensor<3x5x4x3xi16>}> : () -> tensor<3x5x4x3xi16>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<3x5x4x3xi16>) -> tensor<3x5x1x3xi16>
    %2 = tosa.bitwise_and %1, %1 : (tensor<3x5x1x3xi16>, tensor<3x5x1x3xi16>) -> tensor<3x5x1x3xi16>
    %3 = tosa.clamp %2 {max_val = 157 : i16, min_val = 43 : i16} : (tensor<3x5x1x3xi16>) -> tensor<3x5x1x3xi16>
    %4 = tosa.add %3, %3 : (tensor<3x5x1x3xi16>, tensor<3x5x1x3xi16>) -> tensor<3x5x1x3xi16>
    %5 = tosa.bitwise_not %4 : (tensor<3x5x1x3xi16>) -> tensor<3x5x1x3xi16>
    %cast = tensor.cast %5 : tensor<3x5x1x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


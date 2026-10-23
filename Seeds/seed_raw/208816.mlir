module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<23> : tensor<4x3x1x7xi16>}> : () -> tensor<4x3x1x7xi16>
    %1 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<4x3x1x7xi16>) -> tensor<4x3x1x1xi16>
    %2 = tosa.clamp %1 {max_val = 51 : i16, min_val = -19 : i16} : (tensor<4x3x1x1xi16>) -> tensor<4x3x1x1xi16>
    %3 = tosa.const_shape  {values = dense<[3, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %2, %3 : (tensor<4x3x1x1xi16>, !tosa.shape<4>) -> tensor<12x3x3x1xi16>
    %cast = tensor.cast %4 : tensor<12x3x3x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


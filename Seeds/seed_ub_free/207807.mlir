module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<176> : tensor<7x4x7xi16>}> : () -> tensor<7x4x7xi16>
    %1 = "tosa.const"() <{values = dense<55> : tensor<7x4x7xi16>}> : () -> tensor<7x4x7xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x4x7xi16>}> : () -> tensor<7x4x7xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<7x4x7xi16>}> : () -> tensor<7x4x7xi16>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<7x4x7xi16>, tensor<7x4x7xi16>) -> tensor<7x4x7xi16>
    %clamped_shift = tosa.minimum %clamped_lower, %c15 : (tensor<7x4x7xi16>, tensor<7x4x7xi16>) -> tensor<7x4x7xi16>
    %2 = tosa.logical_left_shift %0, %clamped_shift : (tensor<7x4x7xi16>, tensor<7x4x7xi16>) -> tensor<7x4x7xi16>
    %cast = tensor.cast %2 : tensor<7x4x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
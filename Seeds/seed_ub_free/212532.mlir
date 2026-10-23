module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<21> : tensor<7x10x7x1xi16>}> : () -> tensor<7x10x7x1xi16>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7x10x7x1xi16>) -> tensor<1x10x7x1xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x10x7x1xi16>}> : () -> tensor<1x10x7x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<1x10x7x1xi16>}> : () -> tensor<1x10x7x1xi16>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<1x10x7x1xi16>, tensor<1x10x7x1xi16>) -> tensor<1x10x7x1xi16>
    %clamped_shift = tosa.minimum %clamped_lower, %c15 : (tensor<1x10x7x1xi16>, tensor<1x10x7x1xi16>) -> tensor<1x10x7x1xi16>
    %2 = tosa.arithmetic_right_shift %1, %clamped_shift {round = true} : (tensor<1x10x7x1xi16>, tensor<1x10x7x1xi16>) -> tensor<1x10x7x1xi16>
    %cast = tensor.cast %2 : tensor<1x10x7x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
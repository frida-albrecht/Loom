module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-56> : tensor<6x7x8x7xi16>}> : () -> tensor<6x7x8x7xi16>
    %1 = "tosa.const"() <{values = dense<-154> : tensor<6x1x8x1xi16>}> : () -> tensor<6x1x8x1xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x1x8x1xi16>}> : () -> tensor<6x1x8x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<6x1x8x1xi16>}> : () -> tensor<6x1x8x1xi16>
    %tmp0 = tosa.maximum %1, %c0 : (tensor<6x1x8x1xi16>, tensor<6x1x8x1xi16>) -> tensor<6x1x8x1xi16>
    %tmp1 = tosa.minimum %tmp0, %c15 : (tensor<6x1x8x1xi16>, tensor<6x1x8x1xi16>) -> tensor<6x1x8x1xi16>
    %2 = tosa.arithmetic_right_shift %0, %tmp1 {round = true} : (tensor<6x7x8x7xi16>, tensor<6x1x8x1xi16>) -> tensor<6x7x8x7xi16>
    %cast = tensor.cast %2 : tensor<6x7x8x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
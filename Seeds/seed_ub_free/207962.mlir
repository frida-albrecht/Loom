module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-193> : tensor<5x1x3xi16>}> : () -> tensor<5x1x3xi16>
    %1 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<5x1x3xi16>) -> tensor<5x1x1xi16>
    %2 = tosa.bitwise_and %1, %1 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x1x1xi16>}> : () -> tensor<5x1x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<5x1x1xi16>}> : () -> tensor<5x1x1xi16>
    %a1 = tosa.maximum %2, %c0 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %a2 = tosa.minimum %a1, %c15 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %3 = tosa.arithmetic_right_shift %2, %a2 {round = false} : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %4 = tosa.bitwise_or %3, %2 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %c2 = "tosa.const"() <{values = dense<0> : tensor<5x1x1xi16>}> : () -> tensor<5x1x1xi16>
    %c3 = "tosa.const"() <{values = dense<15> : tensor<5x1x1xi16>}> : () -> tensor<5x1x1xi16>
    %a3 = tosa.maximum %4, %c2 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %a4 = tosa.minimum %a3, %c3 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %5 = tosa.logical_right_shift %4, %a4 : (tensor<5x1x1xi16>, tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %6 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<5x1x1xi16>) -> tensor<5x1x1xi16>
    %cast = tensor.cast %6 : tensor<5x1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
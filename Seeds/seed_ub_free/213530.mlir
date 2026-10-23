module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-85> : tensor<6x6xi16>}> : () -> tensor<6x6xi16>
    %1 = "tosa.const"() <{values = dense<-98> : tensor<6x6xi16>}> : () -> tensor<6x6xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x6xi16>}> : () -> tensor<6x6xi16>
    %a0 = tosa.maximum %1, %c0 : (tensor<6x6xi16>, tensor<6x6xi16>) -> tensor<6x6xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<6x6xi16>}> : () -> tensor<6x6xi16>
    %a1 = tosa.minimum %a0, %c15 : (tensor<6x6xi16>, tensor<6x6xi16>) -> tensor<6x6xi16>
    %2 = tosa.logical_right_shift %0, %a1 : (tensor<6x6xi16>, tensor<6x6xi16>) -> tensor<6x6xi16>
    %cast = tensor.cast %2 : tensor<6x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
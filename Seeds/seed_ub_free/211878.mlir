module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<7x3x5x6xi16>}> : () -> tensor<7x3x5x6xi16>
    %1 = "tosa.const"() <{values = dense<-89> : tensor<7x1x1x1xi16>}> : () -> tensor<7x1x1x1xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x1x1x1xi16>}> : () -> tensor<7x1x1x1xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<7x1x1x1xi16>}> : () -> tensor<7x1x1x1xi16>
    %l0 = tosa.maximum %1, %c0 : (tensor<7x1x1x1xi16>, tensor<7x1x1x1xi16>) -> tensor<7x1x1x1xi16>
    %l1 = tosa.minimum %l0, %c1 : (tensor<7x1x1x1xi16>, tensor<7x1x1x1xi16>) -> tensor<7x1x1x1xi16>
    %2 = tosa.logical_right_shift %0, %l1 : (tensor<7x3x5x6xi16>, tensor<7x1x1x1xi16>) -> tensor<7x3x5x6xi16>
    %3 = tosa.reverse %2 {axis = 2 : i32} : (tensor<7x3x5x6xi16>) -> tensor<7x3x5x6xi16>
    %4 = tosa.identity %3 : (tensor<7x3x5x6xi16>) -> tensor<7x3x5x6xi16>
    %cast = tensor.cast %4 : tensor<7x3x5x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
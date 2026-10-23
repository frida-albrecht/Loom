module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-148> : tensor<6x10x3xi16>}> : () -> tensor<6x10x3xi16>
    %1 = "tosa.const"() <{values = dense<182> : tensor<6x1x1xi16>}> : () -> tensor<6x1x1xi16>
    %2 = tosa.sub %0, %1 : (tensor<6x10x3xi16>, tensor<6x1x1xi16>) -> tensor<6x10x3xi16>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<6x10x3xi16>) -> tensor<6x10x3xi16>
    %4 = tosa.bitwise_and %3, %3 : (tensor<6x10x3xi16>, tensor<6x10x3xi16>) -> tensor<6x10x3xi16>
    %cast = tensor.cast %4 : tensor<6x10x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


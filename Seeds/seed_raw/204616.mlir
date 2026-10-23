module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-193> : tensor<2x3x3x2xi16>}> : () -> tensor<2x3x3x2xi16>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<2x3x3x2xi16>) -> tensor<2x3x3x2xi16>
    %cast = tensor.cast %1 : tensor<2x3x3x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


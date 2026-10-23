module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-128> : tensor<2x8xi16>}> : () -> tensor<2x8xi16>
    %1 = "tosa.const"() <{values = dense<-105> : tensor<2x21xi16>}> : () -> tensor<2x21xi16>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<2x8xi16>, tensor<2x21xi16>) -> tensor<2x29xi16>
    %cast = tensor.cast %2 : tensor<2x29xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


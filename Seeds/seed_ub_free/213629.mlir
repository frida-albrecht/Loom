module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<2xi16>}> : () -> tensor<2xi16>
    %1 = tosa.bitwise_not %0 : (tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %1 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


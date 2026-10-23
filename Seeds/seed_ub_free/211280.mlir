module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-165> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = tosa.clz %0 : (tensor<1xi16>) -> tensor<1xi16>
    %2 = tosa.abs %1 : (tensor<1xi16>) -> tensor<1xi16>
    %3 = tosa.bitwise_xor %2, %1 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %cast = tensor.cast %3 : tensor<1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


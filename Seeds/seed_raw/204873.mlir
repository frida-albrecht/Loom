module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-33> : tensor<3x5xi16>}> : () -> tensor<3x5xi16>
    %1 = "tosa.const"() <{values = dense<-75> : tensor<1x5xi16>}> : () -> tensor<1x5xi16>
    %2 = tosa.sub %0, %1 : (tensor<3x5xi16>, tensor<1x5xi16>) -> tensor<3x5xi16>
    %3 = tosa.sub %2, %2 : (tensor<3x5xi16>, tensor<3x5xi16>) -> tensor<3x5xi16>
    %4 = tosa.identity %3 : (tensor<3x5xi16>) -> tensor<3x5xi16>
    %cast = tensor.cast %4 : tensor<3x5xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


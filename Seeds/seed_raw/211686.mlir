module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-144> : tensor<8x1x2x5xi16>}> : () -> tensor<8x1x2x5xi16>
    %1 = "tosa.const"() <{values = dense<-74> : tensor<8x1x2x5xi16>}> : () -> tensor<8x1x2x5xi16>
    %2 = tosa.sub %0, %1 : (tensor<8x1x2x5xi16>, tensor<8x1x2x5xi16>) -> tensor<8x1x2x5xi16>
    %cast = tensor.cast %2 : tensor<8x1x2x5xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


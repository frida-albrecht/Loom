module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-144> : tensor<i16>}> : () -> tensor<i16>
    %1 = tosa.abs %0 : (tensor<i16>) -> tensor<i16>
    %2 = tosa.logical_right_shift %1, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %cast = tensor.cast %2 : tensor<i16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


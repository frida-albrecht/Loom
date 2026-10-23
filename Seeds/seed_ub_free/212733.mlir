module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-63> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<53> : tensor<i16>}> : () -> tensor<i16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i16>}> : () -> tensor<i16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<i16>}> : () -> tensor<i16>
    %t0 = tosa.maximum %1, %c0 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %t1 = tosa.minimum %t0, %c1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %2 = tosa.logical_right_shift %0, %t1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %cast = tensor.cast %2 : tensor<i16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<121> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-76> : tensor<i16>}> : () -> tensor<i16>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %3 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<i16>, !tosa.shape<2>) -> tensor<1x1xi16>
    %cast = tensor.cast %4 : tensor<1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


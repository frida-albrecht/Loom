module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-81> : tensor<4x6x5x3xi16>}> : () -> tensor<4x6x5x3xi16>
    %1 = tosa.const_shape  {values = dense<360> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.reshape %0, %1 : (tensor<4x6x5x3xi16>, !tosa.shape<1>) -> tensor<360xi16>
    %cast = tensor.cast %2 : tensor<360xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


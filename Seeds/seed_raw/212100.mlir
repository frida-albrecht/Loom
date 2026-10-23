module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<161> : tensor<10x1x3x2xi16>}> : () -> tensor<10x1x3x2xi16>
    %1 = tosa.const_shape  {values = dense<[3, 20]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<10x1x3x2xi16>, !tosa.shape<2>) -> tensor<3x20xi16>
    %cast = tensor.cast %2 : tensor<3x20xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


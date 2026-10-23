module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<140> : tensor<1x3x2xi16>}> : () -> tensor<1x3x2xi16>
    %1 = "tosa.const"() <{values = dense<161> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<1x3x2xi16>, !tosa.shape<6>, tensor<1xi16>) -> tensor<1x3x2xi16>
    %5 = tosa.identity %4 : (tensor<1x3x2xi16>) -> tensor<1x3x2xi16>
    %cast = tensor.cast %5 : tensor<1x3x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


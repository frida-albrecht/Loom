module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-90> : tensor<2x4xi16>}> : () -> tensor<2x4xi16>
    %1 = "tosa.const"() <{values = dense<192> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<2x4xi16>, !tosa.shape<4>, tensor<1xi16>) -> tensor<2x4xi16>
    %cast = tensor.cast %4 : tensor<2x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


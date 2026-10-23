module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<194> : tensor<5x6x3x10xi16>}> : () -> tensor<5x6x3x10xi16>
    %1 = "tosa.const"() <{values = dense<-160> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<5x6x3x10xi16>, !tosa.shape<8>, tensor<1xi16>) -> tensor<5x6x3x10xi16>
    %5 = tosa.bitwise_not %4 : (tensor<5x6x3x10xi16>) -> tensor<5x6x3x10xi16>
    %cast = tensor.cast %5 : tensor<5x6x3x10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}


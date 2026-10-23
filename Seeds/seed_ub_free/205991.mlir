module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-198> : tensor<4x2x2x4xi16>}> : () -> tensor<4x2x2x4xi16>
    %1 = "tosa.const"() <{values = dense<-200> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<4x2x2x4xi16>, !tosa.shape<8>, tensor<1xi16>) -> tensor<4x2x2x4xi16>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x2x2x4xi16>}> : () -> tensor<4x2x2x4xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<4x2x2x4xi16>}> : () -> tensor<4x2x2x4xi16>
    %l1 = tosa.maximum %4, %c0 : (tensor<4x2x2x4xi16>, tensor<4x2x2x4xi16>) -> tensor<4x2x2x4xi16>
    %l2 = tosa.minimum %l1, %c15 : (tensor<4x2x2x4xi16>, tensor<4x2x2x4xi16>) -> tensor<4x2x2x4xi16>
    %5 = tosa.logical_left_shift %4, %l2 : (tensor<4x2x2x4xi16>, tensor<4x2x2x4xi16>) -> tensor<4x2x2x4xi16>
    %cast = tensor.cast %5 : tensor<4x2x2x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}
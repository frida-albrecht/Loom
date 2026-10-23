module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<7x6xi8>}> : () -> tensor<7x6xi8>
    %2 = "tosa.const"() <{values = dense<-17> : tensor<7x6xi8>}> : () -> tensor<7x6xi8>
    %3 = tosa.const_shape  {values = dense<[1, 2, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %0, %3 : (tensor<4xi16>, !tosa.shape<4>) -> tensor<1x2x1x2xi16>
    %5 = tosa.minimum %1, %2 : (tensor<7x6xi8>, tensor<7x6xi8>) -> tensor<7x6xi8>
    %cast = tensor.cast %4 : tensor<1x2x1x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<7x6xi8> to tensor<*xi8>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}


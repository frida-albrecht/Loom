module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<2x7x7x8xi8>}> : () -> tensor<2x7x7x8xi8>
    %1 = "tosa.const"() <{values = dense<-10> : tensor<1x7x1x1xi8>}> : () -> tensor<1x7x1x1xi8>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<2x7x7x8xi8>, tensor<1x7x1x1xi8>) -> tensor<2x7x7x8xi8>
    %3 = tosa.const_shape  {values = dense<[1, 56, 14]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<2x7x7x8xi8>, !tosa.shape<3>) -> tensor<1x56x14xi8>
    %5 = tosa.minimum %4, %4 : (tensor<1x56x14xi8>, tensor<1x56x14xi8>) -> tensor<1x56x14xi8>
    %6 = tosa.add %5, %5 : (tensor<1x56x14xi8>, tensor<1x56x14xi8>) -> tensor<1x56x14xi8>
    %cast = tensor.cast %6 : tensor<1x56x14xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


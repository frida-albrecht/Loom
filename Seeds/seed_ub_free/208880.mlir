module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<2x5xi8>}> : () -> tensor<2x5xi8>
    %1 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<2x5xi8>, !tosa.shape<2>) -> tensor<6x15xi8>
    %3 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<6x15xi8>, !tosa.shape<2>) -> tensor<6x15xi8>
    %5 = tosa.bitwise_xor %4, %2 : (tensor<6x15xi8>, tensor<6x15xi8>) -> tensor<6x15xi8>
    %cast = tensor.cast %5 : tensor<6x15xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


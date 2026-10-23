module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<7x7x10xi8>}> : () -> tensor<7x7x10xi8>
    %1 = tosa.const_shape  {values = dense<[2, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<7x7x10xi8>, !tosa.shape<3>) -> tensor<14x7x20xi8>
    %3 = tosa.abs %2 : (tensor<14x7x20xi8>) -> tensor<14x7x20xi8>
    %4 = tosa.minimum %3, %2 : (tensor<14x7x20xi8>, tensor<14x7x20xi8>) -> tensor<14x7x20xi8>
    %5 = tosa.bitwise_xor %4, %3 : (tensor<14x7x20xi8>, tensor<14x7x20xi8>) -> tensor<14x7x20xi8>
    %cast = tensor.cast %5 : tensor<14x7x20xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


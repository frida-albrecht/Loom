module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<8x7x7xi8>}> : () -> tensor<8x7x7xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1x7x7xi8>}> : () -> tensor<1x7x7xi8>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<8x7x7xi8>, tensor<1x7x7xi8>) -> tensor<8x7x7xi8>
    %cast = tensor.cast %2 : tensor<8x7x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


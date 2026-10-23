module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<9xi8>}> : () -> tensor<9xi8>
    %1 = "tosa.const"() <{values = dense<20> : tensor<9xi8>}> : () -> tensor<9xi8>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %3 = tosa.bitwise_or %2, %2 : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %cast = tensor.cast %3 : tensor<9xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


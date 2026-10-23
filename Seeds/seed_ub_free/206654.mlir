module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<9xi8>}> : () -> tensor<9xi8>
    %1 = "tosa.const"() <{values = dense<20> : tensor<9xi8>}> : () -> tensor<9xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9xi8>}> : () -> tensor<9xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<9xi8>}> : () -> tensor<9xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %a2 = tosa.minimum %a1, %c1 : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = true} : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %3 = tosa.bitwise_or %2, %2 : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %cast = tensor.cast %3 : tensor<9xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
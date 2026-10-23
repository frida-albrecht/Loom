module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<9x8xi8>}> : () -> tensor<9x8xi8>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<9x8xi8>) -> tensor<9x8xi8>
    %2 = tosa.bitwise_not %1 : (tensor<9x8xi8>) -> tensor<9x8xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x8xi8>}> : () -> tensor<9x8xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<9x8xi8>}> : () -> tensor<9x8xi8>
    %a4 = tosa.maximum %2, %c0 : (tensor<9x8xi8>, tensor<9x8xi8>) -> tensor<9x8xi8>
    %a5 = tosa.minimum %a4, %c7 : (tensor<9x8xi8>, tensor<9x8xi8>) -> tensor<9x8xi8>
    %3 = tosa.logical_left_shift %2, %a5 : (tensor<9x8xi8>, tensor<9x8xi8>) -> tensor<9x8xi8>
    %cast = tensor.cast %3 : tensor<9x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
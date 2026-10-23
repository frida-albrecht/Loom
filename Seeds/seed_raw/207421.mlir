module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3> : tensor<3x2x5x6xi8>}> : () -> tensor<3x2x5x6xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<3x2x16x6xi8>}> : () -> tensor<3x2x16x6xi8>
    %2 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<3x2x5x6xi8>, tensor<3x2x16x6xi8>) -> tensor<3x2x21x6xi8>
    %cast = tensor.cast %2 : tensor<3x2x21x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


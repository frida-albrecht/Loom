module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<4x9x7x10xi8>}> : () -> tensor<4x9x7x10xi8>
    %1 = "tosa.const"() <{values = dense<10> : tensor<4x9x7x10xi8>}> : () -> tensor<4x9x7x10xi8>
    %2 = tosa.minimum %0, %1 : (tensor<4x9x7x10xi8>, tensor<4x9x7x10xi8>) -> tensor<4x9x7x10xi8>
    %3 = tosa.bitwise_and %2, %2 : (tensor<4x9x7x10xi8>, tensor<4x9x7x10xi8>) -> tensor<4x9x7x10xi8>
    %4 = tosa.sub %3, %3 : (tensor<4x9x7x10xi8>, tensor<4x9x7x10xi8>) -> tensor<4x9x7x10xi8>
    %cast = tensor.cast %4 : tensor<4x9x7x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7> : tensor<10x2x8xi8>}> : () -> tensor<10x2x8xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<10x1x8xi8>}> : () -> tensor<10x1x8xi8>
    %2 = tosa.maximum %0, %1 : (tensor<10x2x8xi8>, tensor<10x1x8xi8>) -> tensor<10x2x8xi8>
    %cast = tensor.cast %2 : tensor<10x2x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


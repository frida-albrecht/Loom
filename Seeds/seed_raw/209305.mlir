module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<7x8x3x2xi8>}> : () -> tensor<7x8x3x2xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<7x1x1x1xi8>}> : () -> tensor<7x1x1x1xi8>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<7x8x3x2xi8>, tensor<7x1x1x1xi8>) -> tensor<7x8x3x2xi8>
    %3 = tosa.sub %2, %2 : (tensor<7x8x3x2xi8>, tensor<7x8x3x2xi8>) -> tensor<7x8x3x2xi8>
    %cast = tensor.cast %3 : tensor<7x8x3x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


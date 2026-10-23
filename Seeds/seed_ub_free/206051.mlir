module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<5x2xi8>}> : () -> tensor<5x2xi8>
    %1 = "tosa.const"() <{values = dense<16> : tensor<5x2xi8>}> : () -> tensor<5x2xi8>
    %c0 = "tosa.const"() <{values = dense<7> : tensor<5x2xi8>}> : () -> tensor<5x2xi8>
    %c1 = tosa.minimum %1, %c0 : (tensor<5x2xi8>, tensor<5x2xi8>) -> tensor<5x2xi8>
    %2 = tosa.logical_left_shift %0, %c1 : (tensor<5x2xi8>, tensor<5x2xi8>) -> tensor<5x2xi8>
    %3 = tosa.sub %2, %2 : (tensor<5x2xi8>, tensor<5x2xi8>) -> tensor<5x2xi8>
    %cast = tensor.cast %3 : tensor<5x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
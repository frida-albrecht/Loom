module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<1x3xi8>}> : () -> tensor<1x3xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = tosa.negate %0, %1, %2 : (tensor<1x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x3xi8>
    %cast = tensor.cast %3 : tensor<1x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


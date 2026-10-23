module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<1x1x3xi8>}> : () -> tensor<1x1x3xi8>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = tosa.bitwise_and %0, %1 : (tensor<1x1x3xi8>, tensor<1x1x1xi8>) -> tensor<1x1x3xi8>
    %3 = tosa.minimum %2, %2 : (tensor<1x1x3xi8>, tensor<1x1x3xi8>) -> tensor<1x1x3xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x3xi8>}> : () -> tensor<1x1x3xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x1x3xi8>}> : () -> tensor<1x1x3xi8>
    %clamped_lower = tosa.maximum %2, %c0 : (tensor<1x1x3xi8>, tensor<1x1x3xi8>) -> tensor<1x1x3xi8>
    %clamped_shift = tosa.minimum %clamped_lower, %c7 : (tensor<1x1x3xi8>, tensor<1x1x3xi8>) -> tensor<1x1x3xi8>
    %4 = tosa.logical_right_shift %3, %clamped_shift : (tensor<1x1x3xi8>, tensor<1x1x3xi8>) -> tensor<1x1x3xi8>
    %cast = tensor.cast %4 : tensor<1x1x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
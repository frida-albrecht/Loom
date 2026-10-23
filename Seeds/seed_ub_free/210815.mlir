module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<1x3x5xi8>}> : () -> tensor<1x3x5xi8>
    %1 = tosa.identity %0 : (tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x3x5xi8>}> : () -> tensor<1x3x5xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<1x3x5xi8>, tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x3x5xi8>}> : () -> tensor<1x3x5xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<1x3x5xi8>, tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %2 = tosa.arithmetic_right_shift %1, %a2 {round = false} : (tensor<1x3x5xi8>, tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %cast = tensor.cast %2 : tensor<1x3x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<1x3x5xi8>}> : () -> tensor<1x3x5xi8>
    %1 = tosa.identity %0 : (tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %2 = tosa.arithmetic_right_shift %1, %1 {round = false} : (tensor<1x3x5xi8>, tensor<1x3x5xi8>) -> tensor<1x3x5xi8>
    %cast = tensor.cast %2 : tensor<1x3x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


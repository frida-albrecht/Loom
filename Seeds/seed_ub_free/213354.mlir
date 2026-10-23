module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<3x6xi8>}> : () -> tensor<3x6xi8>
    %1 = "tosa.const"() <{values = dense<9> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %s0 = tosa.minimum %1, %c7 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %2 = tosa.logical_right_shift %0, %s0 : (tensor<3x6xi8>, tensor<1x1xi8>) -> tensor<3x6xi8>
    %cast = tensor.cast %2 : tensor<3x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
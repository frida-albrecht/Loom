module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<3x8x5xi8>}> : () -> tensor<3x8x5xi8>
    %1 = "tosa.const"() <{values = dense<-20> : tensor<3x1x1xi8>}> : () -> tensor<3x1x1xi8>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<3x8x5xi8>, tensor<3x1x1xi8>) -> tensor<3x8x5xi8>
    %cast = tensor.cast %2 : tensor<3x8x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


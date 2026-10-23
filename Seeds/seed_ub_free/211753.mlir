module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<3x8x5xi8>}> : () -> tensor<3x8x5xi8>
    %1 = "tosa.const"() <{values = dense<-20> : tensor<3x1x1xi8>}> : () -> tensor<3x1x1xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x1x1xi8>}> : () -> tensor<3x1x1xi8>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<3x1x1xi8>, tensor<3x1x1xi8>) -> tensor<3x1x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<3x1x1xi8>}> : () -> tensor<3x1x1xi8>
    %clamped_shift = tosa.minimum %clamped_lower, %c7 : (tensor<3x1x1xi8>, tensor<3x1x1xi8>) -> tensor<3x1x1xi8>
    %2 = tosa.logical_right_shift %0, %clamped_shift : (tensor<3x8x5xi8>, tensor<3x1x1xi8>) -> tensor<3x8x5xi8>
    %cast = tensor.cast %2 : tensor<3x8x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<4x2x6xi8>}> : () -> tensor<4x2x6xi8>
    %1 = "tosa.const"() <{values = dense<12> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %c2 = "tosa.const"() <{values = dense<7> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %a3 = tosa.maximum %1, %c1 : (tensor<1x1x1xi8>, tensor<1x1x1xi8>) -> tensor<1x1x1xi8>
    %a4 = tosa.minimum %a3, %c2 : (tensor<1x1x1xi8>, tensor<1x1x1xi8>) -> tensor<1x1x1xi8>
    %2 = tosa.logical_right_shift %0, %a4 : (tensor<4x2x6xi8>, tensor<1x1x1xi8>) -> tensor<4x2x6xi8>
    %cast = tensor.cast %2 : tensor<4x2x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
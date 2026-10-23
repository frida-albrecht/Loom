module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<12> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<11> : tensor<i8>}> : () -> tensor<i8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<i8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<i8>}> : () -> tensor<i8>
    %a1 = tosa.maximum %1, %c0 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %2 = tosa.logical_right_shift %0, %a2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %2 : tensor<i8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
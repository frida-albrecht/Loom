module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<1x2x4xi8>}> : () -> tensor<1x2x4xi8>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x2x4xi8>}> : () -> tensor<1x2x4xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x2x4xi8>}> : () -> tensor<1x2x4xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<1x2x4xi8>, tensor<1x2x4xi8>) -> tensor<1x2x4xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x2x4xi8>}> : () -> tensor<1x2x4xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<1x2x4xi8>, tensor<1x2x4xi8>) -> tensor<1x2x4xi8>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = true} : (tensor<1x2x4xi8>, tensor<1x2x4xi8>) -> tensor<1x2x4xi8>
    %3 = tosa.clamp %2 {max_val = 116 : i8, min_val = 25 : i8} : (tensor<1x2x4xi8>) -> tensor<1x2x4xi8>
    %cast = tensor.cast %3 : tensor<1x2x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
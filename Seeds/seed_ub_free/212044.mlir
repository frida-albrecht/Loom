module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<1xi8>}> : () -> tensor<1xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = true} : (tensor<4xi8>, tensor<1xi8>) -> tensor<4xi8>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %cast = tensor.cast %3 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
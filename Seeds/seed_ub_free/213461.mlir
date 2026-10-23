module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<4x3x6xi8>}> : () -> tensor<4x3x6xi8>
    %1 = tosa.const_shape  {values = dense<72> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.reshape %0, %1 : (tensor<4x3x6xi8>, !tosa.shape<1>) -> tensor<72xi8>
    %3 = tosa.minimum %2, %2 : (tensor<72xi8>, tensor<72xi8>) -> tensor<72xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<72xi8>}> : () -> tensor<72xi8>
    %a0 = tosa.maximum %2, %c0 : (tensor<72xi8>, tensor<72xi8>) -> tensor<72xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<72xi8>}> : () -> tensor<72xi8>
    %a1 = tosa.minimum %a0, %c7 : (tensor<72xi8>, tensor<72xi8>) -> tensor<72xi8>
    %4 = tosa.arithmetic_right_shift %3, %a1 {round = true} : (tensor<72xi8>, tensor<72xi8>) -> tensor<72xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %7 = tosa.negate %4, %5, %6 : (tensor<72xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<72xi8>
    %cast = tensor.cast %7 : tensor<72xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
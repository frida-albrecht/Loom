module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<9x3xi8>}> : () -> tensor<9x3xi8>
    %1 = "tosa.const"() <{values = dense<14> : tensor<9x3xi8>}> : () -> tensor<9x3xi8>
    %2 = tosa.sub %0, %1 : (tensor<9x3xi8>, tensor<9x3xi8>) -> tensor<9x3xi8>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<9x3xi8>, tensor<9x3xi8>) -> tensor<9x3xi8>
    %4 = tosa.logical_right_shift %3, %2 : (tensor<9x3xi8>, tensor<9x3xi8>) -> tensor<9x3xi8>
    %5 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.tile %4, %5 : (tensor<9x3xi8>, !tosa.shape<2>) -> tensor<27x9xi8>
    %cast = tensor.cast %6 : tensor<27x9xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


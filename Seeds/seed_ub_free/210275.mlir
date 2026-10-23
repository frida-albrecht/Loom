module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<4x5xi8>}> : () -> tensor<4x5xi8>
    %1 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<4x5xi8>, !tosa.shape<2>) -> tensor<8x10xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x10xi8>}> : () -> tensor<8x10xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<8x10xi8>}> : () -> tensor<8x10xi8>
    %a1 = tosa.maximum %2, %c0 : (tensor<8x10xi8>, tensor<8x10xi8>) -> tensor<8x10xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<8x10xi8>, tensor<8x10xi8>) -> tensor<8x10xi8>
    %3 = tosa.arithmetic_right_shift %2, %a2 {round = false} : (tensor<8x10xi8>, tensor<8x10xi8>) -> tensor<8x10xi8>
    %4 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<8x10xi8>) -> tensor<1x10xi8>
    %cast = tensor.cast %4 : tensor<1x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
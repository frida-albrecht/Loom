module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<8x4x6xi8>}> : () -> tensor<8x4x6xi8>
    %1 = "tosa.const"() <{values = dense<8> : tensor<8x1x6xi8>}> : () -> tensor<8x1x6xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x1x6xi8>}> : () -> tensor<8x1x6xi8>
    %s0 = tosa.maximum %1, %c0 : (tensor<8x1x6xi8>, tensor<8x1x6xi8>) -> tensor<8x1x6xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<8x1x6xi8>}> : () -> tensor<8x1x6xi8>
    %s1 = tosa.minimum %s0, %c1 : (tensor<8x1x6xi8>, tensor<8x1x6xi8>) -> tensor<8x1x6xi8>
    %2 = tosa.arithmetic_right_shift %0, %s1 {round = true} : (tensor<8x4x6xi8>, tensor<8x1x6xi8>) -> tensor<8x4x6xi8>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<8x4x6xi8>) -> tensor<8x1x6xi8>
    %4 = tosa.const_shape  {values = dense<48> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.reshape %3, %4 : (tensor<8x1x6xi8>, !tosa.shape<1>) -> tensor<48xi8>
    %cast = tensor.cast %5 : tensor<48xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
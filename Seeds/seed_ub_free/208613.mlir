module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<7x3xi8>}> : () -> tensor<7x3xi8>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<7x3xi8>) -> tensor<7x3xi8>
    %2 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %1, %2 : (tensor<7x3xi8>, !tosa.shape<2>) -> tensor<7x6xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x6xi8>}> : () -> tensor<7x6xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<7x6xi8>}> : () -> tensor<7x6xi8>
    %s1 = tosa.maximum %3, %c0 : (tensor<7x6xi8>, tensor<7x6xi8>) -> tensor<7x6xi8>
    %s2 = tosa.minimum %s1, %c7 : (tensor<7x6xi8>, tensor<7x6xi8>) -> tensor<7x6xi8>
    %4 = tosa.logical_right_shift %3, %s2 : (tensor<7x6xi8>, tensor<7x6xi8>) -> tensor<7x6xi8>
    %5 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.tile %4, %5 : (tensor<7x6xi8>, !tosa.shape<2>) -> tensor<14x12xi8>
    %cast = tensor.cast %6 : tensor<14x12xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
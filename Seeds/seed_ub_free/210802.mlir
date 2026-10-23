module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<5x4xi8>}> : () -> tensor<5x4xi8>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<1x4xi8>}> : () -> tensor<1x4xi8>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<1x4xi8>}> : () -> tensor<1x4xi8>
    %tmp0 = tosa.maximum %1, %c1 : (tensor<1x4xi8>, tensor<1x4xi8>) -> tensor<1x4xi8>
    %c2 = "tosa.const"() <{values = dense<7> : tensor<1x4xi8>}> : () -> tensor<1x4xi8>
    %tmp1 = tosa.minimum %tmp0, %c2 : (tensor<1x4xi8>, tensor<1x4xi8>) -> tensor<1x4xi8>
    %2 = tosa.arithmetic_right_shift %0, %tmp1 {round = false} : (tensor<5x4xi8>, tensor<1x4xi8>) -> tensor<5x4xi8>
    %3 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<5x4xi8>, !tosa.shape<2>) -> tensor<10x8xi8>
    %cast = tensor.cast %4 : tensor<10x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
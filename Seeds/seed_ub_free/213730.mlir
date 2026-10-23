module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<4x3x8x8xi8>}> : () -> tensor<4x3x8x8xi8>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<1x3x8x8xi8>}> : () -> tensor<1x3x8x8xi8>
    %2 = tosa.maximum %0, %1 : (tensor<4x3x8x8xi8>, tensor<1x3x8x8xi8>) -> tensor<4x3x8x8xi8>
    %3 = tosa.const_shape  {values = dense<[2, 2, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %2, %3 : (tensor<4x3x8x8xi8>, !tosa.shape<4>) -> tensor<8x6x24x24xi8>
    %cast = tensor.cast %4 : tensor<8x6x24x24xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<3x10x5xi8>}> : () -> tensor<3x10x5xi8>
    %1 = tosa.identity %0 : (tensor<3x10x5xi8>) -> tensor<3x10x5xi8>
    %2 = tosa.const_shape  {values = dense<[1, 5, 1, 30]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %1, %2 : (tensor<3x10x5xi8>, !tosa.shape<4>) -> tensor<1x5x1x30xi8>
    %4 = tosa.bitwise_and %3, %3 : (tensor<1x5x1x30xi8>, tensor<1x5x1x30xi8>) -> tensor<1x5x1x30xi8>
    %cast = tensor.cast %4 : tensor<1x5x1x30xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


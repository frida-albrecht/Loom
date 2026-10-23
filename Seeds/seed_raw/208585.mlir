module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<3x6x1x4xi8>}> : () -> tensor<3x6x1x4xi8>
    %1 = "tosa.const"() <{values = dense<-126> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %0, %2, %3 : (tensor<3x6x1x4xi8>, !tosa.shape<8>, tensor<1xi8>) -> tensor<3x6x1x4xi8>
    %5 = tosa.const_shape  {values = dense<[1, 36, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %4, %5 : (tensor<3x6x1x4xi8>, !tosa.shape<3>) -> tensor<1x36x2xi8>
    %cast = tensor.cast %6 : tensor<1x36x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


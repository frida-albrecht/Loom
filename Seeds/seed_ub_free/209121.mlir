module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<6x1x6xi8>}> : () -> tensor<6x1x6xi8>
    %1 = "tosa.const"() <{values = dense<-11> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<6x1x6xi8>, tensor<1x1x1xi8>) -> tensor<6x1x6xi8>
    %3 = tosa.const_shape  {values = dense<[2, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.tile %2, %3 : (tensor<6x1x6xi8>, !tosa.shape<3>) -> tensor<12x1x12xi8>
    %cast = tensor.cast %4 : tensor<12x1x12xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


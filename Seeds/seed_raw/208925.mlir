module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<6xi8>}> : () -> tensor<6xi8>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<6xi8>}> : () -> tensor<6xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %3 = tosa.abs %2 : (tensor<6xi8>) -> tensor<6xi8>
    %4 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.const_shape  {values = dense<4> : tensor<1xindex>} : () -> !tosa.shape<1>
    %6 = tosa.slice %3, %4, %5 : (tensor<6xi8>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<4xi8>
    %cast = tensor.cast %6 : tensor<4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


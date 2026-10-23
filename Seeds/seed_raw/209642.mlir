module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<1x7x6xi8>}> : () -> tensor<1x7x6xi8>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<1x7x6xi8>, tensor<1x1x1xi8>) -> tensor<1x7x6xi8>
    %3 = tosa.logical_right_shift %2, %2 : (tensor<1x7x6xi8>, tensor<1x7x6xi8>) -> tensor<1x7x6xi8>
    %cast = tensor.cast %3 : tensor<1x7x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


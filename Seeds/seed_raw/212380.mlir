module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<6x7x4xi8>}> : () -> tensor<6x7x4xi8>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<6x7x1xi8>}> : () -> tensor<6x7x1xi8>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<6x7x4xi8>, tensor<6x7x1xi8>) -> tensor<6x7x4xi8>
    %cast = tensor.cast %2 : tensor<6x7x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


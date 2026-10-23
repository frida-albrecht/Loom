module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<6x7xi8>}> : () -> tensor<6x7xi8>
    %1 = "tosa.const"() <{values = dense<-7> : tensor<6x7xi8>}> : () -> tensor<6x7xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<6x7xi8>, tensor<6x7xi8>) -> tensor<6x7xi8>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<6x7xi8>, tensor<6x7xi8>) -> tensor<6x7xi8>
    %cast = tensor.cast %3 : tensor<6x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


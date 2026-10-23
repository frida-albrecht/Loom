module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<6x8x7xi8>}> : () -> tensor<6x8x7xi8>
    %1 = "tosa.const"() <{values = dense<4> : tensor<6x8x1xi8>}> : () -> tensor<6x8x1xi8>
    %2 = tosa.minimum %0, %1 : (tensor<6x8x7xi8>, tensor<6x8x1xi8>) -> tensor<6x8x7xi8>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %4 = tosa.bitwise_and %3, %2 : (tensor<6x8x7xi8>, tensor<6x8x7xi8>) -> tensor<6x8x7xi8>
    %cast = tensor.cast %4 : tensor<6x8x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


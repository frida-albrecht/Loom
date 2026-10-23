module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<7xi8>}> : () -> tensor<7xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<7xi8>}> : () -> tensor<7xi8>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<7xi8>, tensor<7xi8>) -> tensor<7xi8>
    %3 = tosa.bitwise_not %2 : (tensor<7xi8>) -> tensor<7xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = tosa.negate %3, %4, %5 : (tensor<7xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<7xi8>
    %7 = tosa.identity %6 : (tensor<7xi8>) -> tensor<7xi8>
    %cast = tensor.cast %7 : tensor<7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


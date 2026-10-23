module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<8x2x3xi8>}> : () -> tensor<8x2x3xi8>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x1x3xi8>}> : () -> tensor<1x1x3xi8>
    %2 = tosa.bitwise_and %0, %1 : (tensor<8x2x3xi8>, tensor<1x1x3xi8>) -> tensor<8x2x3xi8>
    %cast = tensor.cast %2 : tensor<8x2x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


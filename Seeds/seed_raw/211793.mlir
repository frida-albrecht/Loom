module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<10x3xi8>}> : () -> tensor<10x3xi8>
    %1 = "tosa.const"() <{values = dense<-4> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<10x3xi8>, tensor<1x1xi8>) -> tensor<10x3xi8>
    %cast = tensor.cast %2 : tensor<10x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


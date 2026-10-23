module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<4x9xi8>}> : () -> tensor<4x9xi8>
    %1 = "tosa.const"() <{values = dense<-12> : tensor<4x1xi8>}> : () -> tensor<4x1xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<4x9xi8>, tensor<4x1xi8>) -> tensor<4x9xi8>
    %cast = tensor.cast %2 : tensor<4x9xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


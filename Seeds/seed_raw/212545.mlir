module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<2xi8>}> : () -> tensor<2xi8>
    %1 = "tosa.const"() <{values = dense<-9> : tensor<2xi8>}> : () -> tensor<2xi8>
    %2 = tosa.minimum %0, %1 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %cast = tensor.cast %2 : tensor<2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


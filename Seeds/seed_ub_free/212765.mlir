module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<2xi8>}> : () -> tensor<2xi8>
    %1 = "tosa.const"() <{values = dense<-20> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.maximum %0, %1 : (tensor<2xi8>, tensor<1xi8>) -> tensor<2xi8>
    %3 = tosa.sub %2, %2 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %cast = tensor.cast %3 : tensor<2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


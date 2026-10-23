module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-19> : tensor<i8>}> : () -> tensor<i8>
    %2 = tosa.sub %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %2 : tensor<i8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


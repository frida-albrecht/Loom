module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.bitwise_and %0, %1 : (tensor<4xi8>, tensor<1xi8>) -> tensor<4xi8>
    %cast = tensor.cast %2 : tensor<4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<5xi8>}> : () -> tensor<5xi8>
    %1 = "tosa.const"() <{values = dense<14> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<5xi8>, tensor<1xi8>) -> tensor<5xi8>
    %3 = tosa.clz %2 : (tensor<5xi8>) -> tensor<5xi8>
    %4 = tosa.bitwise_not %3 : (tensor<5xi8>) -> tensor<5xi8>
    %cast = tensor.cast %4 : tensor<5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


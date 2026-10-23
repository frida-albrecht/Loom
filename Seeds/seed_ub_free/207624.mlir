module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<10x6xi8>}> : () -> tensor<10x6xi8>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<1x6xi8>}> : () -> tensor<1x6xi8>
    %2 = tosa.minimum %0, %1 : (tensor<10x6xi8>, tensor<1x6xi8>) -> tensor<10x6xi8>
    %3 = tosa.bitwise_not %2 : (tensor<10x6xi8>) -> tensor<10x6xi8>
    %4 = tosa.clz %3 : (tensor<10x6xi8>) -> tensor<10x6xi8>
    %cast = tensor.cast %4 : tensor<10x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


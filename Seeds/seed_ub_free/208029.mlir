module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<6x10x5x1xi8>}> : () -> tensor<6x10x5x1xi8>
    %1 = tosa.identity %0 : (tensor<6x10x5x1xi8>) -> tensor<6x10x5x1xi8>
    %2 = tosa.bitwise_not %1 : (tensor<6x10x5x1xi8>) -> tensor<6x10x5x1xi8>
    %3 = tosa.minimum %2, %1 : (tensor<6x10x5x1xi8>, tensor<6x10x5x1xi8>) -> tensor<6x10x5x1xi8>
    %cast = tensor.cast %3 : tensor<6x10x5x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<8x1x8x5xi8>}> : () -> tensor<8x1x8x5xi8>
    %1 = tosa.bitwise_not %0 : (tensor<8x1x8x5xi8>) -> tensor<8x1x8x5xi8>
    %2 = tosa.maximum %1, %1 : (tensor<8x1x8x5xi8>, tensor<8x1x8x5xi8>) -> tensor<8x1x8x5xi8>
    %cast = tensor.cast %2 : tensor<8x1x8x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


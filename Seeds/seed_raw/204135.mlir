module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<2x6x10x3xi8>}> : () -> tensor<2x6x10x3xi8>
    %1 = tosa.bitwise_not %0 : (tensor<2x6x10x3xi8>) -> tensor<2x6x10x3xi8>
    %cast = tensor.cast %1 : tensor<2x6x10x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


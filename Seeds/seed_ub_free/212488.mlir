module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<1x10xi8>}> : () -> tensor<1x10xi8>
    %1 = tosa.clz %0 : (tensor<1x10xi8>) -> tensor<1x10xi8>
    %cast = tensor.cast %1 : tensor<1x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


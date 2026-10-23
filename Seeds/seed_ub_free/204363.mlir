module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<5x4x1x8xi8>}> : () -> tensor<5x4x1x8xi8>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1x1x1x1xi8>}> : () -> tensor<1x1x1x1xi8>
    %2 = tosa.maximum %0, %1 : (tensor<5x4x1x8xi8>, tensor<1x1x1x1xi8>) -> tensor<5x4x1x8xi8>
    %cast = tensor.cast %2 : tensor<5x4x1x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


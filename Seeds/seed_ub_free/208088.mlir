module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<8x9x3xi8>}> : () -> tensor<8x9x3xi8>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<8x9x3xi8>) -> tensor<8x1x3xi8>
    %cast = tensor.cast %1 : tensor<8x1x3xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


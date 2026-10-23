module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<10x8x10xi8>}> : () -> tensor<10x8x10xi8>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<10x8x10xi8>) -> tensor<10x8x10xi8>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<10x8x10xi8>, tensor<10x8x10xi8>) -> tensor<10x8x10xi8>
    %3 = tosa.bitwise_and %2, %1 : (tensor<10x8x10xi8>, tensor<10x8x10xi8>) -> tensor<10x8x10xi8>
    %cast = tensor.cast %3 : tensor<10x8x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<6xi8>}> : () -> tensor<6xi8>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<6xi8>) -> tensor<6xi8>
    %cast = tensor.cast %1 : tensor<6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


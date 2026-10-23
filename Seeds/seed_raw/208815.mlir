module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<6x4x5xi8>}> : () -> tensor<6x4x5xi8>
    %1 = "tosa.const"() <{values = dense<-11> : tensor<6x11x5xi8>}> : () -> tensor<6x11x5xi8>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<6x4x5xi8>, tensor<6x11x5xi8>) -> tensor<6x15x5xi8>
    %cast = tensor.cast %2 : tensor<6x15x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


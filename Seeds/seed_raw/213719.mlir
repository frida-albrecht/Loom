module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<4x3x4xi8>}> : () -> tensor<4x3x4xi8>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<4x3x4xi8>) -> tensor<4x1x4xi8>
    %cast = tensor.cast %1 : tensor<4x1x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


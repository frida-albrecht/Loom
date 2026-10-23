module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<10x4x5xi8>}> : () -> tensor<10x4x5xi8>
    %1 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<10x4x5xi8>) -> tensor<10x1x5xi8>
    %2 = tosa.clamp %1 {max_val = 127 : i8, min_val = 51 : i8} : (tensor<10x1x5xi8>) -> tensor<10x1x5xi8>
    %cast = tensor.cast %2 : tensor<10x1x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


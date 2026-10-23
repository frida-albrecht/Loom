module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<10x5xi8>}> : () -> tensor<10x5xi8>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<10x5xi8>) -> tensor<10x5xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10x5xi8>}> : () -> tensor<10x5xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<10x5xi8>}> : () -> tensor<10x5xi8>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<10x5xi8>, tensor<10x5xi8>) -> tensor<10x5xi8>
    %clamped_shift = tosa.minimum %clamped_lower, %c7 : (tensor<10x5xi8>, tensor<10x5xi8>) -> tensor<10x5xi8>
    %2 = tosa.logical_left_shift %1, %clamped_shift : (tensor<10x5xi8>, tensor<10x5xi8>) -> tensor<10x5xi8>
    %3 = tosa.abs %2 : (tensor<10x5xi8>) -> tensor<10x5xi8>
    %4 = tosa.clz %3 : (tensor<10x5xi8>) -> tensor<10x5xi8>
    %cast = tensor.cast %4 : tensor<10x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
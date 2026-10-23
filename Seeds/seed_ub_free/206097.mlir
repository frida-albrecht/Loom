module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<5x5xi8>}> : () -> tensor<5x5xi8>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<5x5xi8>) -> tensor<1x5xi8>
    %2 = tosa.reverse %1 {axis = 1 : i32} : (tensor<1x5xi8>) -> tensor<1x5xi8>
    %3 = tosa.abs %2 : (tensor<1x5xi8>) -> tensor<1x5xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x5xi8>}> : () -> tensor<1x5xi8>
    %s0 = tosa.maximum %3, %c0 : (tensor<1x5xi8>, tensor<1x5xi8>) -> tensor<1x5xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x5xi8>}> : () -> tensor<1x5xi8>
    %s1 = tosa.minimum %s0, %c7 : (tensor<1x5xi8>, tensor<1x5xi8>) -> tensor<1x5xi8>
    %4 = tosa.logical_right_shift %3, %s1 : (tensor<1x5xi8>, tensor<1x5xi8>) -> tensor<1x5xi8>
    %5 = tosa.minimum %4, %4 : (tensor<1x5xi8>, tensor<1x5xi8>) -> tensor<1x5xi8>
    %6 = tosa.minimum %5, %1 : (tensor<1x5xi8>, tensor<1x5xi8>) -> tensor<1x5xi8>
    %cast = tensor.cast %6 : tensor<1x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
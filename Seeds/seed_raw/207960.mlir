module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<2x4x9x5xi8>}> : () -> tensor<2x4x9x5xi8>
    %1 = "tosa.const"() <{values = dense<-4> : tensor<1x4x1x5xi8>}> : () -> tensor<1x4x1x5xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<2x4x9x5xi8>, tensor<1x4x1x5xi8>) -> tensor<2x4x9x5xi8>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = false} : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<2x4x9x5xi8>
    %5 = tosa.concat %4, %4 {axis = 0 : i32} : (tensor<2x4x9x5xi8>, tensor<2x4x9x5xi8>) -> tensor<4x4x9x5xi8>
    %cast = tensor.cast %5 : tensor<4x4x9x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


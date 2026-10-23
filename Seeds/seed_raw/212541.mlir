module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<5x4x8x4xi8>}> : () -> tensor<5x4x8x4xi8>
    %1 = "tosa.const"() <{values = dense<16> : tensor<5x1x8x4xi8>}> : () -> tensor<5x1x8x4xi8>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<5x4x8x4xi8>, tensor<5x1x8x4xi8>) -> tensor<5x4x8x4xi8>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<5x4x8x4xi8>, tensor<5x4x8x4xi8>) -> tensor<5x4x8x4xi8>
    %cast = tensor.cast %3 : tensor<5x4x8x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}


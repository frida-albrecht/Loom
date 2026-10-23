module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<5x4x8x4xi8>}> : () -> tensor<5x4x8x4xi8>
    %1 = "tosa.const"() <{values = dense<16> : tensor<5x1x8x4xi8>}> : () -> tensor<5x1x8x4xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x1x8x4xi8>}> : () -> tensor<5x1x8x4xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<5x1x8x4xi8>}> : () -> tensor<5x1x8x4xi8>
    %a1 = tosa.maximum %1, %c0 : (tensor<5x1x8x4xi8>, tensor<5x1x8x4xi8>) -> tensor<5x1x8x4xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<5x1x8x4xi8>, tensor<5x1x8x4xi8>) -> tensor<5x1x8x4xi8>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = false} : (tensor<5x4x8x4xi8>, tensor<5x1x8x4xi8>) -> tensor<5x4x8x4xi8>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<5x4x8x4xi8>, tensor<5x4x8x4xi8>) -> tensor<5x4x8x4xi8>
    %cast = tensor.cast %3 : tensor<5x4x8x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}
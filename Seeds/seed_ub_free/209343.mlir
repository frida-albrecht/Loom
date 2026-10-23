module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<9x10x1x10xi8>}> : () -> tensor<9x10x1x10xi8>
    %1 = "tosa.const"() <{values = dense<13> : tensor<9x10x1x10xi8>}> : () -> tensor<9x10x1x10xi8>
    %2 = tosa.bitwise_or %0, %1 : (tensor<9x10x1x10xi8>, tensor<9x10x1x10xi8>) -> tensor<9x10x1x10xi8>
    %3 = tosa.const_shape  {values = dense<[5, 1, 180, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<9x10x1x10xi8>, !tosa.shape<4>) -> tensor<5x1x180x1xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x1x180x1xi8>}> : () -> tensor<5x1x180x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<5x1x180x1xi8>}> : () -> tensor<5x1x180x1xi8>
    %b0 = tosa.maximum %4, %c0 : (tensor<5x1x180x1xi8>, tensor<5x1x180x1xi8>) -> tensor<5x1x180x1xi8>
    %b1 = tosa.minimum %b0, %c7 : (tensor<5x1x180x1xi8>, tensor<5x1x180x1xi8>) -> tensor<5x1x180x1xi8>
    %5 = tosa.arithmetic_right_shift %4, %b1 {round = true} : (tensor<5x1x180x1xi8>, tensor<5x1x180x1xi8>) -> tensor<5x1x180x1xi8>
    %6 = tosa.argmax %5 {axis = 1 : i32} : (tensor<5x1x180x1xi8>) -> tensor<5x180x1xi32>
    %7 = tosa.bitwise_and %6, %6 : (tensor<5x180x1xi32>, tensor<5x180x1xi32>) -> tensor<5x180x1xi32>
    %cast = tensor.cast %7 : tensor<5x180x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<46> : tensor<8xi64>}> : () -> tensor<8xi64>
    %1 = tosa.const_shape  {values = dense<[1, 2, 1, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<8xi64>, !tosa.shape<4>) -> tensor<1x2x1x4xi64>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<1x2x1x4xi64>, tensor<1x2x1x4xi64>) -> tensor<1x2x1x4xi64>
    %4 = tosa.const_shape  {values = dense<8> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.reshape %3, %4 : (tensor<1x2x1x4xi64>, !tosa.shape<1>) -> tensor<8xi64>
    %6 = tosa.concat %5, %5 {axis = 0 : i32} : (tensor<8xi64>, tensor<8xi64>) -> tensor<16xi64>
    %7 = tosa.bitwise_or %6, %6 : (tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %8 = tosa.bitwise_and %7, %6 : (tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %cast = tensor.cast %8 : tensor<16xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<43> : tensor<9xi64>}> : () -> tensor<9xi64>
    %1 = "tosa.const"() <{values = dense<5.075000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.const_shape  {values = dense<[1, 1, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %0, %2 : (tensor<9xi64>, !tosa.shape<4>) -> tensor<1x1x3x3xi64>
    %4 = tosa.exp %1 : (tensor<7xf32>) -> tensor<7xf32>
    %5 = tosa.tanh %4 : (tensor<7xf32>) -> tensor<7xf32>
    %6 = tosa.log %5 : (tensor<7xf32>) -> tensor<7xf32>
    %7 = tosa.bitwise_xor %3, %3 : (tensor<1x1x3x3xi64>, tensor<1x1x3x3xi64>) -> tensor<1x1x3x3xi64>
    %8 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<1xf32>
    %9 = tosa.logical_right_shift %3, %7 : (tensor<1x1x3x3xi64>, tensor<1x1x3x3xi64>) -> tensor<1x1x3x3xi64>
    %cast = tensor.cast %6 : tensor<7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<1x1x3x3xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}


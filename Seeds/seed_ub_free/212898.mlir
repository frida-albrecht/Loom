module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.465000e+01> : tensor<5x2xf32>}> : () -> tensor<5x2xf32>
    %1 = "tosa.const"() <{values = dense<119> : tensor<7x2x1xi64>}> : () -> tensor<7x2x1xi64>
    %2 = "tosa.const"() <{values = dense<9> : tensor<1x2x1xi64>}> : () -> tensor<1x2x1xi64>
    %3 = tosa.const_shape  {values = dense<[2, 5]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %0, %3 : (tensor<5x2xf32>, !tosa.shape<2>) -> tensor<2x5xf32>
    %5 = tosa.bitwise_xor %1, %2 : (tensor<7x2x1xi64>, tensor<1x2x1xi64>) -> tensor<7x2x1xi64>
    %6 = tosa.logical_left_shift %5, %5 : (tensor<7x2x1xi64>, tensor<7x2x1xi64>) -> tensor<7x2x1xi64>
    %7 = tosa.reciprocal %4 : (tensor<2x5xf32>) -> tensor<2x5xf32>
    %8 = tosa.sub %5, %5 : (tensor<7x2x1xi64>, tensor<7x2x1xi64>) -> tensor<7x2x1xi64>
    %cast = tensor.cast %6 : tensor<7x2x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<2x5xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<7x2x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<133> : tensor<9x2x1x10xi64>}> : () -> tensor<9x2x1x10xi64>
    %1 = "tosa.const"() <{values = dense<-111> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %2 = "tosa.const"() <{values = dense<80.1699981> : tensor<5x8x1xf32>}> : () -> tensor<5x8x1xf32>
    %3 = "tosa.const"() <{values = dense<-9.829000e+01> : tensor<5x8x1xf32>}> : () -> tensor<5x8x1xf32>
    %4 = tosa.bitwise_and %0, %1 : (tensor<9x2x1x10xi64>, tensor<1x1x1x1xi64>) -> tensor<9x2x1x10xi64>
    %5 = tosa.pow %2, %3 : (tensor<5x8x1xf32>, tensor<5x8x1xf32>) -> tensor<5x8x1xf32>
    %6 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<9x2x1x10xi64>) -> tensor<1x2x1x10xi64>
    %7 = tosa.const_shape  {values = dense<[3, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %8 = tosa.tile %5, %7 : (tensor<5x8x1xf32>, !tosa.shape<3>) -> tensor<15x16x1xf32>
    %9 = tosa.reverse %8 {axis = 1 : i32} : (tensor<15x16x1xf32>) -> tensor<15x16x1xf32>
    %10 = tosa.arithmetic_right_shift %6, %6 {round = false} : (tensor<1x2x1x10xi64>, tensor<1x2x1x10xi64>) -> tensor<1x2x1x10xi64>
    %cast = tensor.cast %9 : tensor<15x16x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<1x2x1x10xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


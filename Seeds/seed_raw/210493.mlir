module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-41> : tensor<1x4xi64>}> : () -> tensor<1x4xi64>
    %1 = "tosa.const"() <{values = dense<6.800000e+00> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<[1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %0, %2 : (tensor<1x4xi64>, !tosa.shape<2>) -> tensor<1x12xi64>
    %4 = tosa.const_shape  {values = dense<[2, 6]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.reshape %3, %4 : (tensor<1x12xi64>, !tosa.shape<2>) -> tensor<2x6xi64>
    %6 = tosa.logical_left_shift %5, %5 : (tensor<2x6xi64>, tensor<2x6xi64>) -> tensor<2x6xi64>
    %7 = tosa.floor %1 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.reciprocal %7 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.concat %5, %6 {axis = 1 : i32} : (tensor<2x6xi64>, tensor<2x6xi64>) -> tensor<2x12xi64>
    %10 = tosa.arithmetic_right_shift %9, %9 {round = false} : (tensor<2x12xi64>, tensor<2x12xi64>) -> tensor<2x12xi64>
    %11 = tosa.const_shape  {values = dense<[1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %12 = tosa.tile %6, %11 : (tensor<2x6xi64>, !tosa.shape<2>) -> tensor<2x18xi64>
    %cast = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<2x12xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %12 : tensor<2x18xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}


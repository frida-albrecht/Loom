module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-72> : tensor<5x8x5x2xi64>}> : () -> tensor<5x8x5x2xi64>
    %1 = "tosa.const"() <{values = dense<167> : tensor<5x8x1x2xi64>}> : () -> tensor<5x8x1x2xi64>
    %2 = "tosa.const"() <{values = dense<1.558400e+02> : tensor<6x9x2xf32>}> : () -> tensor<6x9x2xf32>
    %3 = tosa.add %0, %1 : (tensor<5x8x5x2xi64>, tensor<5x8x1x2xi64>) -> tensor<5x8x5x2xi64>
    %4 = tosa.tanh %2 : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %5 = tosa.tanh %4 : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %6 = tosa.tanh %4 : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %7 = tosa.arithmetic_right_shift %3, %3 {round = false} : (tensor<5x8x5x2xi64>, tensor<5x8x5x2xi64>) -> tensor<5x8x5x2xi64>
    %8 = tosa.clamp %6 {max_val = 4.200000e+01 : f32, min_val = -2.600000e+01 : f32} : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %9 = tosa.reciprocal %5 : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %10 = tosa.logical_right_shift %7, %3 : (tensor<5x8x5x2xi64>, tensor<5x8x5x2xi64>) -> tensor<5x8x5x2xi64>
    %11 = tosa.maximum %8, %8 : (tensor<6x9x2xf32>, tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %12 = tosa.const_shape  {values = dense<[1, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %13 = tosa.tile %9, %12 : (tensor<6x9x2xf32>, !tosa.shape<3>) -> tensor<6x27x4xf32>
    %14 = tosa.rsqrt %11 : (tensor<6x9x2xf32>) -> tensor<6x9x2xf32>
    %cast = tensor.cast %10 : tensor<5x8x5x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %13 : tensor<6x27x4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %14 : tensor<6x9x2xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


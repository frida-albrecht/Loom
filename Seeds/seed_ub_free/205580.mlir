module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.698100e+02> : tensor<3x9x8x2xf32>}> : () -> tensor<3x9x8x2xf32>
    %1 = tosa.const_shape  {values = dense<[1, 3, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<3x9x8x2xf32>, !tosa.shape<4>) -> tensor<3x27x16x6xf32>
    %3 = tosa.rsqrt %2 : (tensor<3x27x16x6xf32>) -> tensor<3x27x16x6xf32>
    %4 = tosa.maximum %3, %3 : (tensor<3x27x16x6xf32>, tensor<3x27x16x6xf32>) -> tensor<3x27x16x6xf32>
    %5 = tosa.reduce_product %4 {axis = 2 : i32} : (tensor<3x27x16x6xf32>) -> tensor<3x27x1x6xf32>
    %cast = tensor.cast %5 : tensor<3x27x1x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


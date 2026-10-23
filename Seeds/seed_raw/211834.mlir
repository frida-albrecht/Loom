module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<83.0299987> : tensor<3x9x8x1xf32>}> : () -> tensor<3x9x8x1xf32>
    %1 = tosa.rsqrt %0 : (tensor<3x9x8x1xf32>) -> tensor<3x9x8x1xf32>
    %2 = tosa.const_shape  {values = dense<[1, 3, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %1, %2 : (tensor<3x9x8x1xf32>, !tosa.shape<4>) -> tensor<3x27x24x3xf32>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<3x27x24x3xf32>) -> tensor<1x27x24x3xf32>
    %5 = tosa.reduce_max %4 {axis = 3 : i32} : (tensor<1x27x24x3xf32>) -> tensor<1x27x24x1xf32>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<1x27x24x1xf32>) -> tensor<1x1x24x1xf32>
    %cast = tensor.cast %6 : tensor<1x1x24x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


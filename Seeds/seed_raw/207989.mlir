module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.369000e+01> : tensor<4x8x1xf32>}> : () -> tensor<4x8x1xf32>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<4x8x1xf32>) -> tensor<4x8x1xf32>
    %2 = tosa.add %1, %1 : (tensor<4x8x1xf32>, tensor<4x8x1xf32>) -> tensor<4x8x1xf32>
    %3 = tosa.rsqrt %2 : (tensor<4x8x1xf32>) -> tensor<4x8x1xf32>
    %4 = tosa.clamp %3 {max_val = 5.600000e+01 : f32, min_val = 5.000000e+00 : f32} : (tensor<4x8x1xf32>) -> tensor<4x8x1xf32>
    %5 = tosa.floor %4 : (tensor<4x8x1xf32>) -> tensor<4x8x1xf32>
    %6 = tosa.reduce_max %5 {axis = 1 : i32} : (tensor<4x8x1xf32>) -> tensor<4x1x1xf32>
    %cast = tensor.cast %6 : tensor<4x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


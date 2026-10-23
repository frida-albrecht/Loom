module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<1x8x3x3xi32>}> : () -> tensor<1x8x3x3xi32>
    %1 = "tosa.const"() <{values = dense<48> : tensor<1x1x3x3xi32>}> : () -> tensor<1x1x3x3xi32>
    %2 = "tosa.const"() <{values = dense<7.166000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.intdiv %0, %1 : (tensor<1x8x3x3xi32>, tensor<1x1x3x3xi32>) -> tensor<1x8x3x3xi32>
    %4 = tosa.reduce_sum %3 {axis = 2 : i32} : (tensor<1x8x3x3xi32>) -> tensor<1x8x1x3xi32>
    %5 = tosa.sub %4, %4 : (tensor<1x8x1x3xi32>, tensor<1x8x1x3xi32>) -> tensor<1x8x1x3xi32>
    %6 = tosa.reduce_max %5 {axis = 1 : i32} : (tensor<1x8x1x3xi32>) -> tensor<1x1x1x3xi32>
    %7 = tosa.log %2 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.reduce_max %6 {axis = 3 : i32} : (tensor<1x1x1x3xi32>) -> tensor<1x1x1x1xi32>
    %9 = tosa.logical_right_shift %8, %8 : (tensor<1x1x1x1xi32>, tensor<1x1x1x1xi32>) -> tensor<1x1x1x1xi32>
    %10 = tosa.clamp %7 {max_val = 7.600000e+01 : f32, min_val = 3.500000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %9 : tensor<1x1x1x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


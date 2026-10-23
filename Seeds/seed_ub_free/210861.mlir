module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<200> : tensor<4x1x3xi64>}> : () -> tensor<4x1x3xi64>
    %1 = "tosa.const"() <{values = dense<4> : tensor<1x1x3xi64>}> : () -> tensor<1x1x3xi64>
    %2 = "tosa.const"() <{values = dense<5.269000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.minimum %0, %1 : (tensor<4x1x3xi64>, tensor<1x1x3xi64>) -> tensor<4x1x3xi64>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<4x1x3xi64>) -> tensor<1x1x3xi64>
    %5 = tosa.abs %4 : (tensor<1x1x3xi64>) -> tensor<1x1x3xi64>
    %6 = tosa.clamp %5 {max_val = 23 : i64, min_val = -39 : i64} : (tensor<1x1x3xi64>) -> tensor<1x1x3xi64>
    %7 = tosa.reduce_product %6 {axis = 1 : i32} : (tensor<1x1x3xi64>) -> tensor<1x1x3xi64>
    %8 = tosa.log %2 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.rsqrt %8 : (tensor<f32>) -> tensor<f32>
    %10 = tosa.tanh %9 : (tensor<f32>) -> tensor<f32>
    %11 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %12 = tosa.reshape %10, %11 : (tensor<f32>, !tosa.shape<3>) -> tensor<1x1x1xf32>
    %cast = tensor.cast %7 : tensor<1x1x3xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %12 : tensor<1x1x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


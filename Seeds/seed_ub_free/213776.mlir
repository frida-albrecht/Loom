module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<10x8x1x5xi32>}> : () -> tensor<10x8x1x5xi32>
    %1 = "tosa.const"() <{values = dense<-4.078000e+01> : tensor<10xf32>}> : () -> tensor<10xf32>
    %2 = tosa.reverse %0 {axis = 3 : i32} : (tensor<10x8x1x5xi32>) -> tensor<10x8x1x5xi32>
    %3 = tosa.tanh %1 : (tensor<10xf32>) -> tensor<10xf32>
    %4 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<10x8x1x5xi32>) -> tensor<1x8x1x5xi32>
    %5 = tosa.rsqrt %3 : (tensor<10xf32>) -> tensor<10xf32>
    %6 = tosa.logical_left_shift %4, %4 : (tensor<1x8x1x5xi32>, tensor<1x8x1x5xi32>) -> tensor<1x8x1x5xi32>
    // UB detected for tosa.pow:
    // Input value1 (%5) is rsqrt(%3). %3 is tanh(-40.78), which is approx -1.0.
    // rsqrt(-1.0) is typically NaN for floating point.
    // Constraint 1: value1 >= 0. NaN is not >= 0.
    // Constraint 3: !isNaN(value1) && !isNaN(value2). If %5 is NaN, this is violated.
    // Constraint 4: is_finite(value1) && is_finite(value2). If %5 is NaN or Inf, this is violated.
    //
    // Fix: Clamp value1 (%5) to be within [FLT_MIN_POSITIVE, FLT_MAX] and non-NaN.
    // Fix: Clamp value2 (%3) to be within [-FLT_MAX, FLT_MAX] and non-NaN.
    // Assumption: tosa.minimum/maximum when used for clamping in fix context will resolve NaN by picking the non-NaN operand.
    %c0 = "tosa.const"() <{values = dense<1.175494351e-38> : tensor<10xf32>}> : () -> tensor<10xf32>
    %c1 = "tosa.const"() <{values = dense<3.402823466e+38> : tensor<10xf32>}> : () -> tensor<10xf32>
    %c2 = "tosa.const"() <{values = dense<-3.402823466e+38> : tensor<10xf32>}> : () -> tensor<10xf32>
    // Sanitize value1 (%5): clamp to [FLT_MIN_POSITIVE, FLT_MAX] and handle NaN
    %s0 = tosa.maximum %5, %c0 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %s1 = tosa.minimum %s0, %c1 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    // Sanitize value2 (%3): clamp to [-FLT_MAX, FLT_MAX] and handle NaN
    %s2 = tosa.maximum %3, %c2 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %s3 = tosa.minimum %s2, %c1 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %7 = tosa.pow %s1, %s3 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %cast = tensor.cast %6 : tensor<1x8x1x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
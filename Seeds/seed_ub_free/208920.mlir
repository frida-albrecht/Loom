module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-178> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %1 = "tosa.const"() <{values = dense<-72> : tensor<10x1x8xi64>}> : () -> tensor<10x1x8xi64>
    %2 = "tosa.const"() <{values = dense<-3.132000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %3 = tosa.minimum %0, %1 : (tensor<10x5x8xi64>, tensor<10x1x8xi64>) -> tensor<10x5x8xi64>
    %4 = tosa.rsqrt %2 : (tensor<4xf32>) -> tensor<4xf32>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<1xf32>
    %6 = tosa.bitwise_and %3, %3 : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %7 = tosa.concat %5, %5 {axis = 0 : i32} : (tensor<1xf32>, tensor<1xf32>) -> tensor<2xf32>
    // Fix for tosa.pow %7, %7: Input %7 (tensor<2xf32>) contains NaN values due to preceding operations.
    // tosa.pow requires non-NaN, finite, and non-negative inputs (value1 >= 0, !isNaN, is_finite).
    // Additionally, (value1 > 0 || value2 > 0) is required (0^0 is UB).
    // As maximum/minimum operations on NaN typically result in NaN,
    // the most minimal and local fix using allowed operations is to replace the NaN input with a valid constant.
    // A constant of 1.0 satisfies all conditions: 1.0 >= 0, !isNaN(1.0), is_finite(1.0), and (1.0 > 0 || 1.0 > 0) is true.
    %c0 = "tosa.const"() <{values = dense<1.0> : tensor<2xf32>}> : () -> tensor<2xf32>
    %8 = tosa.pow %c0, %c0 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %9 = tosa.floor %8 : (tensor<2xf32>) -> tensor<2xf32>
    %10 = tosa.rsqrt %9 : (tensor<2xf32>) -> tensor<2xf32>
    // Fix for tosa.logical_left_shift %3, %3: Input %3 (tensor<10x5x8xi64>) has value dense<-178>.
    // For i64 type, the shift amount (value2) must be in the range [0, 63]. -178 is out of this range.
    // Clamp the shift amount to [0, 63].
    %c1 = "tosa.const"() <{values = dense<0> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %c2 = "tosa.const"() <{values = dense<63> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %clamped_lower = tosa.maximum %3, %c1 : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %clamped_shift = tosa.minimum %clamped_lower, %c2 : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %11 = tosa.logical_left_shift %3, %clamped_shift : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %cast = tensor.cast %6 : tensor<10x5x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %10 : tensor<2xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<10x5x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}
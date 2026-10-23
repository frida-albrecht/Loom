module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.562000e+02> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %1 = "tosa.const"() <{values = dense<91.1999969> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = "tosa.const"() <{values = dense<-200> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %3 = "tosa.const"() <{values = dense<-142> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    // Original op: %4 = tosa.pow %0, %1 : (tensor<6x8xf32>, tensor<1x1xf32>) -> tensor<6x8xf32>
    // Undefined behavior detected for tosa.pow: Requirement 'value1 >= 0' is violated.
    // The first operand (%0) contains negative values (-156.2), while tosa.pow requires a non-negative base.
    // Fix: Clamp %0 to be maximum(0.0, %0).
    %c1 = "tosa.const"() <{values = dense<0.0> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %f0 = tosa.maximum %0, %c1 : (tensor<6x8xf32>, tensor<6x8xf32>) -> tensor<6x8xf32>
    %4 = tosa.pow %f0, %1 : (tensor<6x8xf32>, tensor<1x1xf32>) -> tensor<6x8xf32>
    // After previous fix, %f0 is non-negative.
    // If %f0 was originally negative, it becomes 0.0.
    // So %4 will be pow(0.0, 91.1999969) which is 0.0.

    // Original op: %5 = tosa.pow %4, %4 : (tensor<6x8xf32>, tensor<6x8xf32>) -> tensor<6x8xf32>
    // Undefined behavior detected for tosa.pow: Requirement 'value1 > 0 || value2 > 0' is violated.
    // Since %4 could be 0.0 (from the previous operation if %0 was negative),
    // %4^%4 could evaluate to 0.0^0.0, which violates the requirement.
    // Fix: If the base is 0.0, clamp the exponent to be at least 1.0 to resolve 0^0.
    %c2 = "tosa.const"() <{values = dense<1.0> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %f1 = tosa.maximum %4, %c2 : (tensor<6x8xf32>, tensor<6x8xf32>) -> tensor<6x8xf32>
    %5 = tosa.pow %4, %f1 : (tensor<6x8xf32>, tensor<6x8xf32>) -> tensor<6x8xf32>
    %6 = tosa.rsqrt %5 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %7 = tosa.abs %6 : (tensor<6x8xf32>) -> tensor<6x8xf32>

    // Original op: %8 = tosa.logical_left_shift %2, %3 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    // Undefined behavior detected for tosa.logical_left_shift:
    // For i64 type, the shift amount (value2) must be in the range [0, 63].
    // The second operand (%3) contains value -142, which is outside this range.
    // Fix: Clamp %3 to the valid range [0, 63].
    %c3 = "tosa.const"() <{values = dense<0> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %f2 = tosa.maximum %3, %c3 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    %c4 = "tosa.const"() <{values = dense<63> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %f3 = tosa.minimum %f2, %c4 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    %8 = tosa.logical_left_shift %2, %f3 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    %cast = tensor.cast %7 : tensor<6x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x8xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}
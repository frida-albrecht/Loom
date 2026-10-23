module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.471700e+02> : tensor<10x2x4x1xf32>}> : () -> tensor<10x2x4x1xf32>
    %1 = "tosa.const"() <{values = dense<-3.934000e+01> : tensor<10x1x1x1xf32>}> : () -> tensor<10x1x1x1xf32>
    // Fix 1: Ensure base (operand 0) is non-negative for tosa.pow, i.e., value1 >= 0.
    // %0 has shape tensor<10x2x4x1xf32> and contains negative values.
    // Clamp %0 with 0.0.
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<10x2x4x1xf32>}> : () -> tensor<10x2x4x1xf32>
    %b1 = tosa.maximum %0, %c0 : (tensor<10x2x4x1xf32>, tensor<10x2x4x1xf32>) -> tensor<10x2x4x1xf32>
    // After Fix 1, %b1 contains 0.0 everywhere.
    //
    // Fix 2: Ensure (value1 > 0 || value2 > 0) for tosa.pow.
    // Since %b1 (value1) is now 0.0, value2 (exponent) must be strictly greater than 0.
    // Original exponent %1 has shape tensor<10x1x1x1xf32> and contains negative values (-39.34).
    // Clamp %1 to be non-negative first, then strictly positive.
    %c2 = "tosa.const"() <{values = dense<0.0> : tensor<10x1x1x1xf32>}> : () -> tensor<10x1x1x1xf32>
    %c3 = "tosa.const"() <{values = dense<1.0> : tensor<10x1x1x1xf32>}> : () -> tensor<10x1x1x1xf32>
    %e4 = tosa.maximum %1, %c2 : (tensor<10x1x1x1xf32>, tensor<10x1x1x1xf32>) -> tensor<10x1x1x1xf32>
    // %e4 will contain 0.0 everywhere (max(-39.34, 0.0)).
    // To satisfy value2 > 0 (as base is 0), further clamp %e4 with 1.0.
    %e5 = tosa.maximum %e4, %c3 : (tensor<10x1x1x1xf32>, tensor<10x1x1x1xf32>) -> tensor<10x1x1x1xf32>
    // %e5 will now contain 1.0 everywhere (max(0.0, 1.0)).
    //
    // The tosa.pow operation now uses %b1 (base 0.0) and %e5 (exponent 1.0).
    // Constraints check for tosa.pow(%b1, %e5):
    // - value1 >= 0: %b1 is 0.0, so 0.0 >= 0 is true. (Satisfied)
    // - (value1 > 0 || value2 > 0): (0.0 > 0 || 1.0 > 0) is (false || true) which is true. (Satisfied)
    %2 = tosa.pow %b1, %e5 : (tensor<10x2x4x1xf32>, tensor<10x1x1x1xf32>) -> tensor<10x2x4x1xf32>
    %cast = tensor.cast %2 : tensor<10x2x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
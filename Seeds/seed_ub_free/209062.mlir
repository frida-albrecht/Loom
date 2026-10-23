module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<108> : tensor<1x7x2x4xi32>}> : () -> tensor<1x7x2x4xi32>
    %1 = "tosa.const"() <{values = dense<47> : tensor<1x7x1x1xi32>}> : () -> tensor<1x7x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-6.723000e+01> : tensor<1x9x10xf32>}> : () -> tensor<1x9x10xf32>

    // Output Inference:
    // %0: tensor<1x7x2x4xi32>, values = 108
    // %1: tensor<1x7x1x1xi32>, values = 47
    // %2: tensor<1x9x10xf32>, values = -67.23

    // Processing operation: %3 = tosa.logical_left_shift %0, %1 : (tensor<1x7x2x4xi32>, tensor<1x7x1x1xi32>) -> tensor<1x7x2x4xi32>
    // Op: tosa.logical_left_shift.
    // Requirement for tosa.logical_left_shift: (is_same<in_out_t,i32_t>() && 0 <= value2 && value2 <= 31)
    // Input %1 (value2) is tensor<1x7x1x1xi32> with value 47.
    // For i32, value2 must be between 0 and 31. Current value 47 violates this constraint.
    // UB detected: Shift amount 47 is out of range [0, 31] for i32.
    // Fixing UB: Clamp %1 to [0, 31].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x7x1x1xi32>}> : () -> tensor<1x7x1x1xi32>
    %v1 = tosa.maximum %1, %c0 : (tensor<1x7x1x1xi32>, tensor<1x7x1x1xi32>) -> tensor<1x7x1x1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1x7x1x1xi32>}> : () -> tensor<1x7x1x1xi32>
    %v2 = tosa.minimum %v1, %c31 : (tensor<1x7x1x1xi32>, tensor<1x7x1x1xi32>) -> tensor<1x7x1x1xi32>
    // %v2 is now the sanitized shift amount, with value 31.

    %3 = tosa.logical_left_shift %0, %v2 : (tensor<1x7x2x4xi32>, tensor<1x7x1x1xi32>) -> tensor<1x7x2x4xi32>
    // Output Inference: %3: tensor<1x7x2x4xi32>, values = 108 << 31 (which is INT_MIN for i32, non-zero).

    // Processing operation: %4 = tosa.intdiv %3, %3 : (tensor<1x7x2x4xi32>, tensor<1x7x2x4xi32>) -> tensor<1x7x2x4xi32>
    // Op: tosa.intdiv.
    // Requirement for tosa.intdiv: value2 != 0.
    // Input %3 (value2) is tensor<1x7x2x4xi32> with a non-zero value (108 << 31).
    // No UB detected.
    %4 = tosa.intdiv %3, %3 : (tensor<1x7x2x4xi32>, tensor<1x7x2x4xi32>) -> tensor<1x7x2x4xi32>
    // Output Inference: %4: tensor<1x7x2x4xi32>, values = 1.

    // Processing operation: %5 = tosa.tanh %2 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.tanh is not in the operation_requirement list. Skipping UB detection.
    %5 = tosa.tanh %2 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %5: tensor<1x9x10xf32>.

    // Processing operation: %6 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.reduce_min is not in the operation_requirement list. Skipping UB detection.
    %6 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %6: tensor<1x9x10xf32>.

    // Processing operation: %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    // Op: tosa.const is not in the operation_requirement list for input UB detection. Skipping.
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    // Output Inference: %7: tensor<1xf32>, values = 0.0.

    // Processing operation: %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    // Op: tosa.const is not in the operation_requirement list for input UB detection. Skipping.
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    // Output Inference: %8: tensor<1xf32>, values = 0.0.

    // Processing operation: %9 = tosa.negate %6, %7, %8 : (tensor<1x9x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.negate is not in the operation_requirement list. Skipping UB detection.
    %9 = tosa.negate %6, %7, %8 : (tensor<1x9x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %9: tensor<1x9x10xf32>.

    // Processing operation: %10 = tosa.ceil %9 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.ceil is not in the operation_requirement list. Skipping UB detection.
    %10 = tosa.ceil %9 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %10: tensor<1x9x10xf32>.

    // Processing operation: %11 = tosa.add %9, %6 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.add is not in the operation_requirement list. Skipping UB detection.
    %11 = tosa.add %9, %6 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %11: tensor<1x9x10xf32>.

    // Processing operation: %12 = tosa.add %10, %11 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Op: tosa.add is not in the operation_requirement list. Skipping UB detection.
    %12 = tosa.add %10, %11 : (tensor<1x9x10xf32>, tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    // Output Inference: %12: tensor<1x9x10xf32>.

    %cast = tensor.cast %4 : tensor<1x7x2x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<1x9x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
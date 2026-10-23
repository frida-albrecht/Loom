module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.446700e+02> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    // Output Inference: %0 = tensor<2x2xf32> with all elements -144.67
    // UB Detection: tosa.const not in requirement list. Skipping.
    %1 = tosa.floor %0 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    // Output Inference: %1 = tensor<2x2xf32> with all elements -145.0 (floor(-144.67) = -145.0)
    // UB Detection: tosa.floor not in requirement list. Skipping.

    // The original `tosa.log %1` operation would take %1 (value -145.0) as input.
    // Logarithm of a negative number is undefined (results in NaN for floating point).
    // The subsequent `tosa.pow %2, %2` operation would then have NaN as both its base and exponent.
    // The `tosa.pow` requirement `REQUIRE(!isNaN(value1) && !isNaN(value2));` would be violated.
    // To fix this:
    // 1. Ensure the input to `tosa.log` is strictly positive to prevent NaN or -Infinity.
    // 2. Ensure the output of `tosa.log` (which is %2) is strictly positive to satisfy `tosa.pow`'s `REQUIRE(value1 > 0 || value2 > 0)` constraint,
    //    especially since it's used as both base and exponent (0^0 is UB).

    // Fix 1: Clamp %1 to be at least 1.0 before `tosa.log`.
    // If %1 is -145.0, `tosa.maximum(%1, 1.0)` will yield 1.0.
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %a1 = tosa.maximum %1, %c1 : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    // Output Inference: %a1 = tensor<2x2xf32> with all elements 1.0

    %2 = tosa.log %a1 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    // Output Inference: %2 = tensor<2x2xf32> with all elements log(1.0) = 0.0
    // UB Detection: tosa.log not in requirement list. Skipping.

    // The `tosa.pow %2, %2` operation now has inputs `value1 = 0.0` and `value2 = 0.0`.
    // This violates `tosa.pow` requirement: `REQUIRE(value1 > 0 || value2 > 0);` (because 0 > 0 || 0 > 0 is false).
    // All other tosa.pow requirements (`value1 >= 0`, `!isNaN`, `is_finite`) are met.

    // Fix 2: Clamp %2 to be at least a small positive epsilon (e.g., 1.0e-6) before `tosa.pow`.
    // If %2 is 0.0, `tosa.maximum(%2, 1.0e-6)` will yield 1.0e-6.
    %c2 = "tosa.const"() <{values = dense<1.0e-6> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %a2 = tosa.maximum %2, %c2 : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    // Output Inference: %a2 = tensor<2x2xf32> with all elements 1.0e-6

    %3 = tosa.pow %a2, %a2 : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    // Output Inference: %3 = tensor<2x2xf32> with all elements (1.0e-6)^(1.0e-6) (a small positive number).
    // UB Detection: Checking `tosa.pow` with inputs %a2 (1.0e-6) and %a2 (1.0e-6):
    // - `REQUIRE(value1 >= 0)`: 1.0e-6 >= 0 (True)
    // - `REQUIRE(value1 > 0 || value2 > 0)`: 1.0e-6 > 0 || 1.0e-6 > 0 (True)
    // - `REQUIRE(!isNaN(value1) && !isNaN(value2))`: True
    // - `REQUIRE(is_finite(value1) && is_finite(value2))`: True
    // All `tosa.pow` requirements are now met.

    %cast = tensor.cast %3 : tensor<2x2xf32> to tensor<*xf32>
    // Output Inference: %cast = tensor<*xf32> (same value as %3)
    // UB Detection: tensor.cast not in requirement list. Skipping.
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.499000e+02> : tensor<8x10x9xf32>}> : () -> tensor<8x10x9xf32>
    %1 = "tosa.const"() <{values = dense<-3.838000e+01> : tensor<1x10x1xf32>}> : () -> tensor<1x10x1xf32>
    // Undefined Behavior for tosa.pow detected:
    // Constraint 1: REQUIRE(value1 >= 0) violated by %0 (value1 = -149.9).
    // Constraint 2: REQUIRE(value1 > 0 || value2 > 0) violated by %0 (value1 = -149.9) and %1 (value2 = -38.38).

    // Fix for value1 >= 0: Clamp %0 to be at least 0.0.
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<8x10x9xf32>}> : () -> tensor<8x10x9xf32>
    %clamped0 = tosa.maximum %0, %c0 : (tensor<8x10x9xf32>, tensor<8x10x9xf32>) -> tensor<8x10x9xf32>

    // After clamping, %clamped0 (new value1) is 0.0.
    // Now, to satisfy (value1 > 0 || value2 > 0) when value1 is 0, value2 must be > 0.
    // Original %1 (value2) is -38.38. Clamp %1 to be at least 1.0 (a positive value)
    // to ensure value2 > 0 if value1 is 0.
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<1x10x1xf32>}> : () -> tensor<1x10x1xf32>
    %clamped1 = tosa.maximum %1, %c1 : (tensor<1x10x1xf32>, tensor<1x10x1xf32>) -> tensor<1x10x1xf32>

    %2 = tosa.pow %clamped0, %clamped1 : (tensor<8x10x9xf32>, tensor<1x10x1xf32>) -> tensor<8x10x9xf32>
    %cast = tensor.cast %2 : tensor<8x10x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
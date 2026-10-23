module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.856400e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-1.634100e+02> : tensor<f32>}> : () -> tensor<f32>
    // Fixing UB for %2 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // Original %0 value: -185.640000e+02 (f32)
    // Original %1 value: -163.410000e+02 (f32)

    // Constraint 1: REQUIRE(value1 >= 0)
    // %0 violates this constraint as -185.64 < 0.
    // Insert tosa.maximum with 0.0f to clamp %0.
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %a0 = tosa.maximum %0, %c0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // %a0 now holds max(-185.64, 0.0) = 0.0f

    // Constraint 2: REQUIRE(value1 > 0 || value2 > 0)
    // With %a0 = 0.0 and %1 = -163.41, the constraint (0.0 > 0 || -163.41 > 0) is false.
    // If value1 is 0, value2 must be > 0. Clamp %1 to be at least 1.0f.
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %a1 = tosa.maximum %1, %c1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // %a1 now holds max(-163.41, 1.0) = 1.0f

    %2 = tosa.pow %a0, %a1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
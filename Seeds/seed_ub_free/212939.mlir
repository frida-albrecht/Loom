module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.035000e+01> : tensor<5x6x6x7xf32>}> : () -> tensor<5x6x6x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.922400e+02> : tensor<1x1x6x1xf32>}> : () -> tensor<1x1x6x1xf32>
    // tosa.pow UB Fix 1: The base operand (%0) must be non-negative (value1 >= 0).
    // Original value: -3.035000e+01.
    // Insert tosa.maximum to clamp the base to be at least 0.0.
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<5x6x6x7xf32>}> : () -> tensor<5x6x6x7xf32>
    %a0 = tosa.maximum %0, %c0 : (tensor<5x6x6x7xf32>, tensor<5x6x6x7xf32>) -> tensor<5x6x6x7xf32>
    // tosa.pow UB Fix 2: If the base is 0 (as %a0 is after clamping), the exponent (%1) must be positive (value2 > 0).
    // Original value: -1.922400e+02.
    // Insert tosa.maximum to clamp the exponent to be at least 1.0 to ensure it's positive.
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<1x1x6x1xf32>}> : () -> tensor<1x1x6x1xf32>
    %a1 = tosa.maximum %1, %c1 : (tensor<1x1x6x1xf32>, tensor<1x1x6x1xf32>) -> tensor<1x1x6x1xf32>
    %2 = tosa.pow %a0, %a1 : (tensor<5x6x6x7xf32>, tensor<1x1x6x1xf32>) -> tensor<5x6x6x7xf32>
    %cast = tensor.cast %2 : tensor<5x6x6x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.752000e+01> : tensor<7x9x1x7xf32>}> : () -> tensor<7x9x1x7xf32>
    %1 = "tosa.const"() <{values = dense<17> : tensor<2x1x3x2xi32>}> : () -> tensor<2x1x3x2xi32>
    %2 = "tosa.const"() <{values = dense<-176> : tensor<1x1x1x2xi32>}> : () -> tensor<1x1x1x2xi32>
    %3 = tosa.tanh %0 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %4 = tosa.exp %3 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %5 = tosa.tanh %4 : (tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    // UB detected: tosa.logical_right_shift %1, %2
    // Constraint: value2 (shift amount) must be in [0, 31] for i32. %2 has value -176, which is out of range.
    // Fix: Clamp %2 to [0, 31].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1x2xi32>}> : () -> tensor<1x1x1x2xi32>
    %c1 = tosa.maximum %2, %c0 : (tensor<1x1x1x2xi32>, tensor<1x1x1x2xi32>) -> tensor<1x1x1x2xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<1x1x1x2xi32>}> : () -> tensor<1x1x1x2xi32>
    %c3 = tosa.minimum %c1, %c2 : (tensor<1x1x1x2xi32>, tensor<1x1x1x2xi32>) -> tensor<1x1x1x2xi32>
    %6 = tosa.logical_right_shift %1, %c3 : (tensor<2x1x3x2xi32>, tensor<1x1x1x2xi32>) -> tensor<2x1x3x2xi32>
    %7 = tosa.logical_left_shift %6, %6 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %8 = tosa.pow %4, %3 : (tensor<7x9x1x7xf32>, tensor<7x9x1x7xf32>) -> tensor<7x9x1x7xf32>
    %9 = tosa.intdiv %6, %7 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %10 = tosa.bitwise_or %7, %9 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    // UB detected: tosa.logical_right_shift %9, %10
    // Constraint: value2 (shift amount) must be in [0, 31] for i32. %10 derived value is 2228224, which is out of range.
    // Fix: Clamp %10 to [0, 31].
    %c4 = "tosa.const"() <{values = dense<0> : tensor<2x1x3x2xi32>}> : () -> tensor<2x1x3x2xi32>
    %c5 = tosa.maximum %10, %c4 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %c6 = "tosa.const"() <{values = dense<31> : tensor<2x1x3x2xi32>}> : () -> tensor<2x1x3x2xi32>
    %c7 = tosa.minimum %c5, %c6 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %11 = tosa.logical_right_shift %9, %c7 : (tensor<2x1x3x2xi32>, tensor<2x1x3x2xi32>) -> tensor<2x1x3x2xi32>
    %cast = tensor.cast %5 : tensor<7x9x1x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<7x9x1x7xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<2x1x3x2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}
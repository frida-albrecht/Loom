module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-41> : tensor<9x3x2xi64>}> : () -> tensor<9x3x2xi64>
    %1 = "tosa.const"() <{values = dense<-126> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %2 = "tosa.const"() <{values = dense<-82.6699981> : tensor<8x6xf32>}> : () -> tensor<8x6xf32>
    %3 = "tosa.const"() <{values = dense<1.563300e+02> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    // UB detected for tosa.logical_left_shift: shift amount (%1) is negative (-126) and 'i64' type is not explicitly covered by limits, but generally shift amounts must be non-negative and within bit-width (0-63 for i64).
    // Fixing by clamping the shift amount operand (%1) to be within [0, 63].
    %c1 = "tosa.const"() <{values = dense<0> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %c2 = "tosa.const"() <{values = dense<63> : tensor<9x1x2xi64>}> : () -> tensor<9x1x2xi64>
    %a1 = tosa.maximum %1, %c1 : (tensor<9x1x2xi64>, tensor<9x1x2xi64>) -> tensor<9x1x2xi64>
    %a2 = tosa.minimum %a1, %c2 : (tensor<9x1x2xi64>, tensor<9x1x2xi64>) -> tensor<9x1x2xi64>
    %4 = tosa.logical_left_shift %0, %a2 : (tensor<9x3x2xi64>, tensor<9x1x2xi64>) -> tensor<9x3x2xi64>
    // UB detected for tosa.pow: base operand (%2) must be non-negative (value1 >= 0), but it is -82.6699981.
    // Fixing by clamping the base operand (%2) to be non-negative.
    %c3 = "tosa.const"() <{values = dense<0.0> : tensor<8x6xf32>}> : () -> tensor<8x6xf32>
    %a3 = tosa.maximum %2, %c3 : (tensor<8x6xf32>, tensor<8x6xf32>) -> tensor<8x6xf32>
    %5 = tosa.pow %a3, %3 : (tensor<8x6xf32>, tensor<1x1xf32>) -> tensor<8x6xf32>
    %6 = tosa.exp %5 : (tensor<8x6xf32>) -> tensor<8x6xf32>
    %cast = tensor.cast %4 : tensor<9x3x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<8x6xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
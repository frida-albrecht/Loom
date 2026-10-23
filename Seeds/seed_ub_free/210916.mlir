module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-123> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = "tosa.const"() <{values = dense<152> : tensor<7xi64>}> : () -> tensor<7xi64>
    %2 = "tosa.const"() <{values = dense<-1.405700e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %3 = tosa.maximum %0, %1 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %6 = tosa.negate %3, %4, %5 : (tensor<7xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<7xi64>
    %7 = tosa.rsqrt %2 : (tensor<2xf32>) -> tensor<2xf32>
    // UB detection for tosa.logical_right_shift:
    // The second operand (%3, values = dense<152>) for logical right shift with i64 type.
    // Based on the example, for i64, shift amount must be in the range [0, 63].
    // 152 violates this constraint.
    // Fix: Clamp the shift amount (%3) to be within [0, 63].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7xi64>}> : () -> tensor<7xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<7xi64>}> : () -> tensor<7xi64>
    %clamped_lower = tosa.maximum %3, %c0 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %clamped_shift = tosa.minimum %clamped_lower, %c63 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %8 = tosa.logical_right_shift %6, %clamped_shift : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %9 = tosa.sub %8, %3 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %10 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<1xf32>
    %cast = tensor.cast %9 : tensor<7xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %10 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
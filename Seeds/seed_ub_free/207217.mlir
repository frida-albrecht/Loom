module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<187> : tensor<10x3xi64>}> : () -> tensor<10x3xi64>
    %1 = "tosa.const"() <{values = dense<-99> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    // Undefined Behavior detected for tosa.arithmetic_right_shift:
    // The operation requirement for tosa.arithmetic_right_shift states that for i32, i16, and i8 types,
    // the shift amount (value2) must be non-negative and within the bit-width of the type (e.g., 0-31 for i32).
    // Although i64 is not explicitly listed, based on common shift semantics and example fixes for other shift ops,
    // it is implied that a similar constraint (0-63 for i64) applies.
    // The current shift amount (%1) is -99, which violates the implied lower bound of 0.
    // Fix: Clamp the shift amount to the valid range [0, 63] for i64.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %l1 = tosa.maximum %1, %c0 : (tensor<1x1xi64>, tensor<1x1xi64>) -> tensor<1x1xi64>
    %s1 = tosa.minimum %l1, %c63 : (tensor<1x1xi64>, tensor<1x1xi64>) -> tensor<1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %s1 {round = false} : (tensor<10x3xi64>, tensor<1x1xi64>) -> tensor<10x3xi64>
    %cast = tensor.cast %2 : tensor<10x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
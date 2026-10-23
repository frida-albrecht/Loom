module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-23> : tensor<9x7xi64>}> : () -> tensor<9x7xi64>
    %1 = "tosa.const"() <{values = dense<133> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    // UB Fix for tosa.arithmetic_right_shift: shift amount must be between 0 and 63 for i64.
    // The original shift amount (%1) is 133, which is out of range.
    // Clamp the shift amount to [0, 63].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %s1 = tosa.maximum %1, %c0 : (tensor<1x1xi64>, tensor<1x1xi64>) -> tensor<1x1xi64>
    %safe_shift = tosa.minimum %s1, %c63 : (tensor<1x1xi64>, tensor<1x1xi64>) -> tensor<1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %safe_shift {round = true} : (tensor<9x7xi64>, tensor<1x1xi64>) -> tensor<9x7xi64>
    %cast = tensor.cast %2 : tensor<9x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
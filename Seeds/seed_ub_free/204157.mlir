module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-111> : tensor<6x3x10xi64>}> : () -> tensor<6x3x10xi64>
    %1 = "tosa.const"() <{values = dense<-66> : tensor<6x1x1xi64>}> : () -> tensor<6x1x1xi64>
    // Undefined behavior detected for 'tosa.arithmetic_right_shift':
    // The shift amount operand (%1) with value -66 for a 64-bit integer type (i64)
    // is outside the valid range [0, 63].
    // Fixing by clamping the shift amount to [0, 63].
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x1x1xi64>}> : () -> tensor<6x1x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<6x1x1xi64>}> : () -> tensor<6x1x1xi64>
    %s1 = tosa.maximum %1, %c0 : (tensor<6x1x1xi64>, tensor<6x1x1xi64>) -> tensor<6x1x1xi64>
    %s2 = tosa.minimum %s1, %c63 : (tensor<6x1x1xi64>, tensor<6x1x1xi64>) -> tensor<6x1x1xi64>
    %2 = tosa.arithmetic_right_shift %0, %s2 {round = true} : (tensor<6x3x10xi64>, tensor<6x1x1xi64>) -> tensor<6x3x10xi64>
    %cast = tensor.cast %2 : tensor<6x3x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
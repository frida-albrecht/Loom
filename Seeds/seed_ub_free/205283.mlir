module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<56> : tensor<4x1x5xi64>}> : () -> tensor<4x1x5xi64>
    %1 = tosa.bitwise_not %0 : (tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x1x5xi64>}> : () -> tensor<4x1x5xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<4x1x5xi64>}> : () -> tensor<4x1x5xi64>
    %s1 = tosa.maximum %1, %c0 : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %s2 = tosa.minimum %s1, %c63 : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %2 = tosa.arithmetic_right_shift %1, %s2 {round = true} : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %4 = tosa.logical_right_shift %3, %s2 : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %5 = tosa.maximum %4, %1 : (tensor<4x1x5xi64>, tensor<4x1x5xi64>) -> tensor<4x1x5xi64>
    %cast = tensor.cast %5 : tensor<4x1x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
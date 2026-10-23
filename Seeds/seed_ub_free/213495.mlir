module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<31> : tensor<8x9xi64>}> : () -> tensor<8x9xi64>
    %1 = "tosa.const"() <{values = dense<-149> : tensor<8x9xi64>}> : () -> tensor<8x9xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x9xi64>}> : () -> tensor<8x9xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<8x9xi64>}> : () -> tensor<8x9xi64>
    %a1 = tosa.maximum %1, %c0 : (tensor<8x9xi64>, tensor<8x9xi64>) -> tensor<8x9xi64>
    %s1 = tosa.minimum %a1, %c63 : (tensor<8x9xi64>, tensor<8x9xi64>) -> tensor<8x9xi64>
    %2 = tosa.logical_right_shift %0, %s1 : (tensor<8x9xi64>, tensor<8x9xi64>) -> tensor<8x9xi64>
    %3 = tosa.minimum %2, %2 : (tensor<8x9xi64>, tensor<8x9xi64>) -> tensor<8x9xi64>
    %cast = tensor.cast %3 : tensor<8x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}
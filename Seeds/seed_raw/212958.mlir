module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<42> : tensor<9xi64>}> : () -> tensor<9xi64>
    %1 = "tosa.const"() <{values = dense<-197> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<9xi64>, tensor<1xi64>) -> tensor<9xi64>
    %3 = tosa.sub %2, %2 : (tensor<9xi64>, tensor<9xi64>) -> tensor<9xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %6 = tosa.negate %3, %4, %5 : (tensor<9xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<9xi64>
    %cast = tensor.cast %6 : tensor<9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


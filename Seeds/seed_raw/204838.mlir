module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89> : tensor<7x9xi64>}> : () -> tensor<7x9xi64>
    %1 = "tosa.const"() <{values = dense<40> : tensor<7x1xi64>}> : () -> tensor<7x1xi64>
    %2 = tosa.add %0, %1 : (tensor<7x9xi64>, tensor<7x1xi64>) -> tensor<7x9xi64>
    %3 = tosa.maximum %2, %2 : (tensor<7x9xi64>, tensor<7x9xi64>) -> tensor<7x9xi64>
    %cast = tensor.cast %3 : tensor<7x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


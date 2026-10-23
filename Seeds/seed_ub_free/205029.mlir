module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<56> : tensor<9xi64>}> : () -> tensor<9xi64>
    %1 = "tosa.const"() <{values = dense<-157> : tensor<9xi64>}> : () -> tensor<9xi64>
    %2 = tosa.minimum %0, %1 : (tensor<9xi64>, tensor<9xi64>) -> tensor<9xi64>
    %cast = tensor.cast %2 : tensor<9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<103> : tensor<7x10xi64>}> : () -> tensor<7x10xi64>
    %1 = "tosa.const"() <{values = dense<-58> : tensor<7x1xi64>}> : () -> tensor<7x1xi64>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<7x10xi64>, tensor<7x1xi64>) -> tensor<7x10xi64>
    %cast = tensor.cast %2 : tensor<7x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


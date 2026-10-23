module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<176> : tensor<7x7x5x8xi64>}> : () -> tensor<7x7x5x8xi64>
    %1 = "tosa.const"() <{values = dense<-127> : tensor<7x7x1x8xi64>}> : () -> tensor<7x7x1x8xi64>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<7x7x5x8xi64>, tensor<7x7x1x8xi64>) -> tensor<7x7x5x8xi64>
    %cast = tensor.cast %2 : tensor<7x7x5x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-86> : tensor<4x5xi64>}> : () -> tensor<4x5xi64>
    %1 = "tosa.const"() <{values = dense<37> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = tosa.bitwise_or %0, %1 : (tensor<4x5xi64>, tensor<1x1xi64>) -> tensor<4x5xi64>
    %cast = tensor.cast %2 : tensor<4x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


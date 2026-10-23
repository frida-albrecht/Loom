module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-45> : tensor<7x6x10x7xi64>}> : () -> tensor<7x6x10x7xi64>
    %1 = "tosa.const"() <{values = dense<-68> : tensor<7x6x1x7xi64>}> : () -> tensor<7x6x1x7xi64>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<7x6x10x7xi64>, tensor<7x6x1x7xi64>) -> tensor<7x6x10x7xi64>
    %cast = tensor.cast %2 : tensor<7x6x10x7xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


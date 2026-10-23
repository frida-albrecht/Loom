module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<8x7x6x10xi64>}> : () -> tensor<8x7x6x10xi64>
    %1 = "tosa.const"() <{values = dense<-182> : tensor<8x1x6x10xi64>}> : () -> tensor<8x1x6x10xi64>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<8x7x6x10xi64>, tensor<8x1x6x10xi64>) -> tensor<8x7x6x10xi64>
    %cast = tensor.cast %2 : tensor<8x7x6x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


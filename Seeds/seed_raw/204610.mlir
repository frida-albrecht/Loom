module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-159> : tensor<8x6x3xi64>}> : () -> tensor<8x6x3xi64>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<8x6x3xi64>) -> tensor<8x6x3xi64>
    %cast = tensor.cast %1 : tensor<8x6x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


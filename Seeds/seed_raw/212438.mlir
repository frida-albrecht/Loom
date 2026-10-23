module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73> : tensor<8x2x6x9xi64>}> : () -> tensor<8x2x6x9xi64>
    %1 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<8x2x6x9xi64>) -> tensor<8x2x1x9xi64>
    %cast = tensor.cast %1 : tensor<8x2x1x9xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


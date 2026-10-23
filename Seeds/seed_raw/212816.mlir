module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-156> : tensor<10x8x9xi64>}> : () -> tensor<10x8x9xi64>
    %1 = tosa.reduce_product %0 {axis = 2 : i32} : (tensor<10x8x9xi64>) -> tensor<10x8x1xi64>
    %cast = tensor.cast %1 : tensor<10x8x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


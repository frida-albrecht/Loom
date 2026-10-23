module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-108> : tensor<10x10x8x10xi64>}> : () -> tensor<10x10x8x10xi64>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<10x10x8x10xi64>) -> tensor<10x10x1x10xi64>
    %cast = tensor.cast %1 : tensor<10x10x1x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


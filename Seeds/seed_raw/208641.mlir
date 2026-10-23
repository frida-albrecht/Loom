module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-17> : tensor<6x10x5x8xi64>}> : () -> tensor<6x10x5x8xi64>
    %1 = tosa.reverse %0 {axis = 3 : i32} : (tensor<6x10x5x8xi64>) -> tensor<6x10x5x8xi64>
    %cast = tensor.cast %1 : tensor<6x10x5x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


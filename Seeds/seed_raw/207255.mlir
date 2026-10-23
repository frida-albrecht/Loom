module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-71> : tensor<4x9x10x8xi64>}> : () -> tensor<4x9x10x8xi64>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<4x9x10x8xi64>) -> tensor<4x9x10x1xi64>
    %cast = tensor.cast %1 : tensor<4x9x10x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


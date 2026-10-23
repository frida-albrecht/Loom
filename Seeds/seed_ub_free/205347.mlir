module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-72> : tensor<5x6x9x4xi64>}> : () -> tensor<5x6x9x4xi64>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<5x6x9x4xi64>) -> tensor<5x6x1x4xi64>
    %2 = tosa.sub %1, %1 : (tensor<5x6x1x4xi64>, tensor<5x6x1x4xi64>) -> tensor<5x6x1x4xi64>
    %cast = tensor.cast %2 : tensor<5x6x1x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


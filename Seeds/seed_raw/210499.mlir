module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-118> : tensor<5x7x6x2xi64>}> : () -> tensor<5x7x6x2xi64>
    %1 = "tosa.const"() <{values = dense<-200> : tensor<1x7x1x2xi64>}> : () -> tensor<1x7x1x2xi64>
    %2 = tosa.maximum %0, %1 : (tensor<5x7x6x2xi64>, tensor<1x7x1x2xi64>) -> tensor<5x7x6x2xi64>
    %3 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<5x7x6x2xi64>) -> tensor<5x1x6x2xi64>
    %cast = tensor.cast %3 : tensor<5x1x6x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


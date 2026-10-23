module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-31> : tensor<8xi64>}> : () -> tensor<8xi64>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<8xi64>) -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = tosa.negate %1, %2, %3 : (tensor<1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %5 = tosa.abs %4 : (tensor<1xi64>) -> tensor<1xi64>
    %cast = tensor.cast %5 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


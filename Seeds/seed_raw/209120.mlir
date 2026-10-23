module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-94> : tensor<1x6xi64>}> : () -> tensor<1x6xi64>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<1x6xi64>) -> tensor<1x6xi64>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<1x6xi64>, tensor<1x6xi64>) -> tensor<1x6xi64>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<1x6xi64>) -> tensor<1x6xi64>
    %4 = tosa.clz %3 : (tensor<1x6xi64>) -> tensor<1x6xi64>
    %cast = tensor.cast %4 : tensor<1x6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


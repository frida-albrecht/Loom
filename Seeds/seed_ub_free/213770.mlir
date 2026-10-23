module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-193> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7xi64>) -> tensor<1xi64>
    %2 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<1xi64>) -> tensor<1xi64>
    %3 = tosa.clz %2 : (tensor<1xi64>) -> tensor<1xi64>
    %4 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<1xi64>, !tosa.shape<1>) -> tensor<3xi64>
    %6 = tosa.clz %5 : (tensor<3xi64>) -> tensor<3xi64>
    %7 = tosa.reduce_sum %6 {axis = 0 : i32} : (tensor<3xi64>) -> tensor<1xi64>
    %cast = tensor.cast %7 : tensor<1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


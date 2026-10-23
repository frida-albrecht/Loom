module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-148> : tensor<7xi64>}> : () -> tensor<7xi64>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<7xi64>) -> tensor<1xi64>
    %2 = tosa.abs %1 : (tensor<1xi64>) -> tensor<1xi64>
    %3 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.tile %2, %3 : (tensor<1xi64>, !tosa.shape<1>) -> tensor<3xi64>
    %cast = tensor.cast %4 : tensor<3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


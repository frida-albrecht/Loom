module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-126> : tensor<5x5x9x6xi64>}> : () -> tensor<5x5x9x6xi64>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<5x5x9x6xi64>) -> tensor<5x5x9x1xi64>
    %2 = tosa.const_shape  {values = dense<[5, 3, 15]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.reshape %1, %2 : (tensor<5x5x9x1xi64>, !tosa.shape<3>) -> tensor<5x3x15xi64>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<5x3x15xi64>) -> tensor<5x1x15xi64>
    %5 = tosa.concat %4, %4 {axis = 0 : i32} : (tensor<5x1x15xi64>, tensor<5x1x15xi64>) -> tensor<10x1x15xi64>
    %cast = tensor.cast %5 : tensor<10x1x15xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


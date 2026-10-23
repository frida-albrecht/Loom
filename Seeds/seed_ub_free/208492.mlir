module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<104> : tensor<9x10x6xi64>}> : () -> tensor<9x10x6xi64>
    %1 = tosa.const_shape  {values = dense<[3, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<9x10x6xi64>, !tosa.shape<3>) -> tensor<27x10x12xi64>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<27x10x12xi64>) -> tensor<1x10x12xi64>
    %4 = tosa.bitwise_or %3, %3 : (tensor<1x10x12xi64>, tensor<1x10x12xi64>) -> tensor<1x10x12xi64>
    %cast = tensor.cast %4 : tensor<1x10x12xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}


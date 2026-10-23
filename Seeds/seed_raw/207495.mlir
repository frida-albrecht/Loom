module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-112> : tensor<9x5x5xi32>}> : () -> tensor<9x5x5xi32>
    %1 = tosa.bitwise_not %0 : (tensor<9x5x5xi32>) -> tensor<9x5x5xi32>
    %2 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<9x5x5xi32>) -> tensor<9x1x5xi32>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<9x1x5xi32>, tensor<9x1x5xi32>) -> tensor<9x1x5xi32>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<9x1x5xi32>) -> tensor<1x1x5xi32>
    %5 = tosa.reduce_max %4 {axis = 2 : i32} : (tensor<1x1x5xi32>) -> tensor<1x1x1xi32>
    %cast = tensor.cast %5 : tensor<1x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


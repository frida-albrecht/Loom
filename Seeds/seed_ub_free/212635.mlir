module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<60> : tensor<5x6x9x6xi32>}> : () -> tensor<5x6x9x6xi32>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<5x6x9x6xi32>) -> tensor<1x6x9x6xi32>
    %2 = tosa.reduce_max %1 {axis = 3 : i32} : (tensor<1x6x9x6xi32>) -> tensor<1x6x9x1xi32>
    %3 = tosa.clz %2 : (tensor<1x6x9x1xi32>) -> tensor<1x6x9x1xi32>
    %cast = tensor.cast %3 : tensor<1x6x9x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


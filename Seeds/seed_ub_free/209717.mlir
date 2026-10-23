module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<87> : tensor<5x10xi32>}> : () -> tensor<5x10xi32>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<5x10xi32>) -> tensor<1x10xi32>
    %cast = tensor.cast %1 : tensor<1x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


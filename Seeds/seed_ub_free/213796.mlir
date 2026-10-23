module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-158> : tensor<7x10xi32>}> : () -> tensor<7x10xi32>
    %1 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<7x10xi32>) -> tensor<7x1xi32>
    %2 = tosa.abs %1 : (tensor<7x1xi32>) -> tensor<7x1xi32>
    %cast = tensor.cast %2 : tensor<7x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


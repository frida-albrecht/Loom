module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<97> : tensor<4x10x10xi32>}> : () -> tensor<4x10x10xi32>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<4x10x10xi32>) -> tensor<4x10x1xi32>
    %2 = tosa.identity %1 : (tensor<4x10x1xi32>) -> tensor<4x10x1xi32>
    %cast = tensor.cast %2 : tensor<4x10x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


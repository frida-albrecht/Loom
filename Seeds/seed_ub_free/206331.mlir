module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<182> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %1 = "tosa.const"() <{values = dense<113> : tensor<4x2xi32>}> : () -> tensor<4x2xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<4x2xi32>, tensor<4x2xi32>) -> tensor<4x2xi32>
    %3 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<4x2xi32>) -> tensor<4x1xi32>
    %4 = tosa.bitwise_or %3, %3 : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<4x1xi32>) -> tensor<4x1xi32>
    %cast = tensor.cast %5 : tensor<4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


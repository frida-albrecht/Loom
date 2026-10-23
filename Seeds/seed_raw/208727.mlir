module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<3x4xi1>}> : () -> tensor<3x4xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<3x4xi1>) -> tensor<4xi32>
    %2 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<1xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %3 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


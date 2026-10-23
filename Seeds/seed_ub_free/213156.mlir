module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<170> : tensor<6x2xi64>}> : () -> tensor<6x2xi64>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<6x2xi64>) -> tensor<1x2xi64>
    %2 = tosa.argmax %1 {axis = 1 : i32} : (tensor<1x2xi64>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


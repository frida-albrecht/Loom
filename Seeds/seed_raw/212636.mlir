module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<76> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = tosa.abs %0 : (tensor<7xi32>) -> tensor<7xi32>
    %2 = tosa.identity %1 : (tensor<7xi32>) -> tensor<7xi32>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<7xi32>) -> tensor<1xi32>
    %cast = tensor.cast %3 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


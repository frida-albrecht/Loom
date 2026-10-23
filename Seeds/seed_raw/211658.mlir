module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<151> : tensor<5x10xi32>}> : () -> tensor<5x10xi32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<5x10xi32>) -> tensor<10xi32>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<i32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


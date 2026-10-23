module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-51> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<191> : tensor<i32>}> : () -> tensor<i32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %l0 = tosa.maximum %1, %c0 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %l1 = tosa.minimum %l0, %c31 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = tosa.logical_left_shift %0, %l1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
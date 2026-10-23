module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-148> : tensor<i32>}> : () -> tensor<i32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %a1 = tosa.maximum %1, %c0 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %a2 = tosa.minimum %a1, %c31 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = tosa.logical_right_shift %0, %a2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
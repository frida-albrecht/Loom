module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<110> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-64> : tensor<i32>}> : () -> tensor<i32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %s0 = tosa.minimum %2, %c31 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = tosa.logical_right_shift %2, %s0 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
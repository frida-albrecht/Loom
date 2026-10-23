module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-91> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<84> : tensor<i32>}> : () -> tensor<i32>
    %2 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = tosa.abs %2 : (tensor<i32>) -> tensor<i32>
    %4 = tosa.logical_right_shift %3, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


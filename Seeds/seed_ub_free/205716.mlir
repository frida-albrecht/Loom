module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<35> : tensor<i32>}> : () -> tensor<i32>
    %2 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = tosa.add %2, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


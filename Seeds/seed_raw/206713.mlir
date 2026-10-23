module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<196> : tensor<i32>}> : () -> tensor<i32>
    %1 = tosa.identity %0 : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %1 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x10xi1>}> : () -> tensor<7x10xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<7x1xi1>}> : () -> tensor<7x1xi1>
    %2 = tosa.logical_and %0, %1 : (tensor<7x10xi1>, tensor<7x1xi1>) -> tensor<7x10xi1>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<7x10xi1>) -> tensor<10xi32>
    %cast = tensor.cast %3 : tensor<10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


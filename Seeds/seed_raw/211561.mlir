module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<6x7x4x3xi1>}> : () -> tensor<6x7x4x3xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<6x7x4x3xi1>) -> tensor<7x4x3xi32>
    %2 = tosa.argmax %1 {axis = 1 : i32} : (tensor<7x4x3xi32>) -> tensor<7x3xi32>
    %cast = tensor.cast %2 : tensor<7x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


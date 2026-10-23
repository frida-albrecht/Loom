module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<4x8xi1>}> : () -> tensor<4x8xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<4x1xi1>}> : () -> tensor<4x1xi1>
    %2 = tosa.logical_or %0, %1 : (tensor<4x8xi1>, tensor<4x1xi1>) -> tensor<4x8xi1>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<4x8xi1>) -> tensor<8xi32>
    %4 = tosa.logical_right_shift %3, %3 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %cast = tensor.cast %4 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


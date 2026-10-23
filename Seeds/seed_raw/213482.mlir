module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1x6x1x8xi1>}> : () -> tensor<1x6x1x8xi1>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<1x6x1x8xi1>) -> tensor<1x1x8xi32>
    %2 = tosa.logical_right_shift %1, %1 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %cast = tensor.cast %2 : tensor<1x1x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


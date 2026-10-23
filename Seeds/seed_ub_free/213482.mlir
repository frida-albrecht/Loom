module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1x6x1x8xi1>}> : () -> tensor<1x6x1x8xi1>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<1x6x1x8xi1>) -> tensor<1x1x8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %c1 = tosa.maximum %1, %c0 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<1x1x8xi32>}> : () -> tensor<1x1x8xi32>
    %c3 = tosa.minimum %c1, %c2 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %2 = tosa.logical_right_shift %1, %c3 : (tensor<1x1x8xi32>, tensor<1x1x8xi32>) -> tensor<1x1x8xi32>
    %cast = tensor.cast %2 : tensor<1x1x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
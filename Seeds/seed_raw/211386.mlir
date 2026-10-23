module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<6x4x8x3xi1>}> : () -> tensor<6x4x8x3xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<6x4x8x3xi1>) -> tensor<4x8x3xi32>
    %2 = tosa.bitwise_xor %1, %1 : (tensor<4x8x3xi32>, tensor<4x8x3xi32>) -> tensor<4x8x3xi32>
    %3 = tosa.abs %2 : (tensor<4x8x3xi32>) -> tensor<4x8x3xi32>
    %cast = tensor.cast %3 : tensor<4x8x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


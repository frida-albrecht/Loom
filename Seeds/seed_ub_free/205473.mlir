module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<28> : tensor<4x2x8x10xi16>}> : () -> tensor<4x2x8x10xi16>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<4x2x8x10xi16>) -> tensor<4x8x10xi32>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<4x8x10xi32>, tensor<4x8x10xi32>) -> tensor<4x8x10xi32>
    %cast = tensor.cast %2 : tensor<4x8x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<25> : tensor<8x4x4x8xi32>}> : () -> tensor<8x4x4x8xi32>
    %1 = "tosa.const"() <{values = dense<20> : tensor<8x4x1x1xi32>}> : () -> tensor<8x4x1x1xi32>
    %2 = tosa.maximum %0, %1 : (tensor<8x4x4x8xi32>, tensor<8x4x1x1xi32>) -> tensor<8x4x4x8xi32>
    %cast = tensor.cast %2 : tensor<8x4x4x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


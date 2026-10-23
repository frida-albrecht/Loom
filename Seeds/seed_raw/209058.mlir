module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<59> : tensor<8x4x1xi32>}> : () -> tensor<8x4x1xi32>
    %1 = "tosa.const"() <{values = dense<4> : tensor<8x1x1xi32>}> : () -> tensor<8x1x1xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<8x4x1xi32>, tensor<8x1x1xi32>) -> tensor<8x4x1xi32>
    %cast = tensor.cast %2 : tensor<8x4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


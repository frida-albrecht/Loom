module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<87> : tensor<8x9x5x7xi32>}> : () -> tensor<8x9x5x7xi32>
    %1 = "tosa.const"() <{values = dense<118> : tensor<8x1x1x7xi32>}> : () -> tensor<8x1x1x7xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<8x9x5x7xi32>, tensor<8x1x1x7xi32>) -> tensor<8x9x5x7xi32>
    %cast = tensor.cast %2 : tensor<8x9x5x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


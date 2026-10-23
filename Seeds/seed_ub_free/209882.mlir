module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<104> : tensor<1x3x8x5xi32>}> : () -> tensor<1x3x8x5xi32>
    %1 = "tosa.const"() <{values = dense<-99> : tensor<1x1x8x1xi32>}> : () -> tensor<1x1x8x1xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<1x3x8x5xi32>, tensor<1x1x8x1xi32>) -> tensor<1x3x8x5xi32>
    %cast = tensor.cast %2 : tensor<1x3x8x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-115> : tensor<8x5x6xi32>}> : () -> tensor<8x5x6xi32>
    %1 = "tosa.const"() <{values = dense<11> : tensor<8x5x6xi32>}> : () -> tensor<8x5x6xi32>
    %2 = tosa.minimum %0, %1 : (tensor<8x5x6xi32>, tensor<8x5x6xi32>) -> tensor<8x5x6xi32>
    %cast = tensor.cast %2 : tensor<8x5x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


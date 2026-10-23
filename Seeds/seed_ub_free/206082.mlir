module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<151> : tensor<10x6x1x5xi32>}> : () -> tensor<10x6x1x5xi32>
    %1 = "tosa.const"() <{values = dense<89> : tensor<1x1x1x5xi32>}> : () -> tensor<1x1x1x5xi32>
    %2 = tosa.minimum %0, %1 : (tensor<10x6x1x5xi32>, tensor<1x1x1x5xi32>) -> tensor<10x6x1x5xi32>
    %cast = tensor.cast %2 : tensor<10x6x1x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


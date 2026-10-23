module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<120> : tensor<5x6xi32>}> : () -> tensor<5x6xi32>
    %1 = "tosa.const"() <{values = dense<37> : tensor<5x1xi32>}> : () -> tensor<5x1xi32>
    %2 = tosa.sub %0, %1 : (tensor<5x6xi32>, tensor<5x1xi32>) -> tensor<5x6xi32>
    %cast = tensor.cast %2 : tensor<5x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


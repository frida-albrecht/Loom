module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<136> : tensor<5x4x3xi32>}> : () -> tensor<5x4x3xi32>
    %1 = "tosa.const"() <{values = dense<200> : tensor<5x4x3xi32>}> : () -> tensor<5x4x3xi32>
    %2 = tosa.sub %0, %1 : (tensor<5x4x3xi32>, tensor<5x4x3xi32>) -> tensor<5x4x3xi32>
    %3 = tosa.maximum %2, %2 : (tensor<5x4x3xi32>, tensor<5x4x3xi32>) -> tensor<5x4x3xi32>
    %cast = tensor.cast %3 : tensor<5x4x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


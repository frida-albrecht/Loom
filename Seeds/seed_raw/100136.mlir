module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<4x8x16xi32>}> : () -> tensor<4x8x16xi32>
    %1 = "tosa.const"() <{values = dense<-94> : tensor<4x8x16xi32>}> : () -> tensor<4x8x16xi32>
    %2 = tensor.empty() : tensor<4x8x16xi32>
    %3 = linalg.div_unsigned ins(%0, %1 : tensor<4x8x16xi32>, tensor<4x8x16xi32>) outs(%2 : tensor<4x8x16xi32>) -> tensor<4x8x16xi32>
    %cast = tensor.cast %3 : tensor<4x8x16xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.172700e+02> : tensor<4x8x16xf32>}> : () -> tensor<4x8x16xf32>
    %1 = tensor.empty() : tensor<4x8x16xf32>
    %2 = linalg.negf ins(%0 : tensor<4x8x16xf32>) outs(%1 : tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %cast = tensor.cast %2 : tensor<4x8x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


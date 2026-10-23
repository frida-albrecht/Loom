module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73.6699981> : tensor<4x8x16xf32>}> : () -> tensor<4x8x16xf32>
    %1 = "tosa.const"() <{values = dense<6.969000e+01> : tensor<4x8x16xf32>}> : () -> tensor<4x8x16xf32>
    %2 = tensor.empty() : tensor<4x8x16xf32>
    %3 = linalg.max ins(%0, %1 : tensor<4x8x16xf32>, tensor<4x8x16xf32>) outs(%2 : tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %cast = tensor.cast %3 : tensor<4x8x16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


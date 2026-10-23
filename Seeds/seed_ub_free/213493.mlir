module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.140000e+00> : tensor<8x8x2x3xf32>}> : () -> tensor<8x8x2x3xf32>
    %1 = tosa.exp %0 : (tensor<8x8x2x3xf32>) -> tensor<8x8x2x3xf32>
    %2 = tosa.identity %1 : (tensor<8x8x2x3xf32>) -> tensor<8x8x2x3xf32>
    %cast = tensor.cast %2 : tensor<8x8x2x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


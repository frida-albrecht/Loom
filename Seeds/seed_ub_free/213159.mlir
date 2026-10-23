module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.577100e+02> : tensor<8x10x2x1xf32>}> : () -> tensor<8x10x2x1xf32>
    %1 = tosa.ceil %0 : (tensor<8x10x2x1xf32>) -> tensor<8x10x2x1xf32>
    %2 = tosa.sub %1, %1 : (tensor<8x10x2x1xf32>, tensor<8x10x2x1xf32>) -> tensor<8x10x2x1xf32>
    %cast = tensor.cast %2 : tensor<8x10x2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


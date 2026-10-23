module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.003900e+02> : tensor<8x1x5xf32>}> : () -> tensor<8x1x5xf32>
    %1 = tosa.reciprocal %0 : (tensor<8x1x5xf32>) -> tensor<8x1x5xf32>
    %2 = tosa.tanh %1 : (tensor<8x1x5xf32>) -> tensor<8x1x5xf32>
    %3 = tosa.log %2 : (tensor<8x1x5xf32>) -> tensor<8x1x5xf32>
    %cast = tensor.cast %3 : tensor<8x1x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


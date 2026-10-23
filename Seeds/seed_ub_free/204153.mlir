module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.096500e+02> : tensor<5x3xf32>}> : () -> tensor<5x3xf32>
    %1 = tosa.reciprocal %0 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %2 = tosa.rsqrt %1 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %cast = tensor.cast %2 : tensor<5x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


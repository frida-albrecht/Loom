module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.838000e+01> : tensor<5x9xf32>}> : () -> tensor<5x9xf32>
    %1 = "tosa.const"() <{values = dense<4.755000e+01> : tensor<5x1xf32>}> : () -> tensor<5x1xf32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<5x9xf32>}> : () -> tensor<5x9xf32>
    %p0 = tosa.maximum %0, %c0 : (tensor<5x9xf32>, tensor<5x9xf32>) -> tensor<5x9xf32>
    %2 = tosa.pow %p0, %1 : (tensor<5x9xf32>, tensor<5x1xf32>) -> tensor<5x9xf32>
    %cast = tensor.cast %2 : tensor<5x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
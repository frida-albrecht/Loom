module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.162000e+01> : tensor<5x3xf32>}> : () -> tensor<5x3xf32>
    %1 = tosa.log %0 : (tensor<5x3xf32>) -> tensor<5x3xf32>
    %2 = tosa.sub %1, %1 : (tensor<5x3xf32>, tensor<5x3xf32>) -> tensor<5x3xf32>
    %3 = tosa.minimum %2, %1 : (tensor<5x3xf32>, tensor<5x3xf32>) -> tensor<5x3xf32>
    %cast = tensor.cast %3 : tensor<5x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


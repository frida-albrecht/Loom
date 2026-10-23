module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.588600e+02> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.759600e+02> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %2 = tosa.maximum %0, %1 : (tensor<2x3xf32>, tensor<2x3xf32>) -> tensor<2x3xf32>
    %cast = tensor.cast %2 : tensor<2x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


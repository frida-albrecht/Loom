module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.332000e+01> : tensor<5x9x5xf32>}> : () -> tensor<5x9x5xf32>
    %1 = "tosa.const"() <{values = dense<-1.093900e+02> : tensor<5x1x5xf32>}> : () -> tensor<5x1x5xf32>
    %2 = tosa.minimum %0, %1 : (tensor<5x9x5xf32>, tensor<5x1x5xf32>) -> tensor<5x9x5xf32>
    %cast = tensor.cast %2 : tensor<5x9x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.823200e+02> : tensor<5x9x10x1xf32>}> : () -> tensor<5x9x10x1xf32>
    %1 = tosa.exp %0 : (tensor<5x9x10x1xf32>) -> tensor<5x9x10x1xf32>
    %2 = tosa.exp %1 : (tensor<5x9x10x1xf32>) -> tensor<5x9x10x1xf32>
    %cast = tensor.cast %2 : tensor<5x9x10x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


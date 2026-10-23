module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.851800e+02> : tensor<9x2x9x1xf32>}> : () -> tensor<9x2x9x1xf32>
    %1 = tosa.floor %0 : (tensor<9x2x9x1xf32>) -> tensor<9x2x9x1xf32>
    %2 = tosa.reciprocal %1 : (tensor<9x2x9x1xf32>) -> tensor<9x2x9x1xf32>
    %cast = tensor.cast %2 : tensor<9x2x9x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


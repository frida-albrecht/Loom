module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.027800e+02> : tensor<9x5x1x7xf32>}> : () -> tensor<9x5x1x7xf32>
    %1 = "tosa.const"() <{values = dense<1.172300e+02> : tensor<1x1x1x7xf32>}> : () -> tensor<1x1x1x7xf32>
    %2 = tosa.maximum %0, %1 : (tensor<9x5x1x7xf32>, tensor<1x1x1x7xf32>) -> tensor<9x5x1x7xf32>
    %3 = tosa.tanh %2 : (tensor<9x5x1x7xf32>) -> tensor<9x5x1x7xf32>
    %cast = tensor.cast %3 : tensor<9x5x1x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


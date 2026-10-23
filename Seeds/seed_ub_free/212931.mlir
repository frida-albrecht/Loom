module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.838000e+01> : tensor<9x7xf32>}> : () -> tensor<9x7xf32>
    %1 = "tosa.const"() <{values = dense<1.859700e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %2 = tosa.maximum %0, %1 : (tensor<9x7xf32>, tensor<1x7xf32>) -> tensor<9x7xf32>
    %3 = tosa.pow %2, %2 : (tensor<9x7xf32>, tensor<9x7xf32>) -> tensor<9x7xf32>
    %cast = tensor.cast %3 : tensor<9x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


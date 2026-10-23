module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.113000e+02> : tensor<9x7x6x3xf32>}> : () -> tensor<9x7x6x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.483200e+02> : tensor<1x1x6x1xf32>}> : () -> tensor<1x1x6x1xf32>
    %2 = tosa.sub %0, %1 : (tensor<9x7x6x3xf32>, tensor<1x1x6x1xf32>) -> tensor<9x7x6x3xf32>
    %cast = tensor.cast %2 : tensor<9x7x6x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


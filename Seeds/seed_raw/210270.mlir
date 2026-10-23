module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.497200e+02> : tensor<1x5x3x8xf32>}> : () -> tensor<1x5x3x8xf32>
    %1 = "tosa.const"() <{values = dense<-1.147200e+02> : tensor<1x1x1x1xf32>}> : () -> tensor<1x1x1x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<1x5x3x8xf32>, tensor<1x1x1x1xf32>) -> tensor<1x5x3x8xf32>
    %3 = tosa.ceil %2 : (tensor<1x5x3x8xf32>) -> tensor<1x5x3x8xf32>
    %cast = tensor.cast %3 : tensor<1x5x3x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.080700e+02> : tensor<7x3x4x7xf32>}> : () -> tensor<7x3x4x7xf32>
    %1 = tosa.reciprocal %0 : (tensor<7x3x4x7xf32>) -> tensor<7x3x4x7xf32>
    %2 = tosa.identity %1 : (tensor<7x3x4x7xf32>) -> tensor<7x3x4x7xf32>
    %cast = tensor.cast %2 : tensor<7x3x4x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


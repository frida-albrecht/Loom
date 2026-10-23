module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.742000e+01> : tensor<3x10x3x3xf32>}> : () -> tensor<3x10x3x3xf32>
    %1 = tosa.tanh %0 : (tensor<3x10x3x3xf32>) -> tensor<3x10x3x3xf32>
    %cast = tensor.cast %1 : tensor<3x10x3x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


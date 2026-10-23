module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.636300e+02> : tensor<4x9x9xf32>}> : () -> tensor<4x9x9xf32>
    %1 = tosa.tanh %0 : (tensor<4x9x9xf32>) -> tensor<4x9x9xf32>
    %2 = tosa.ceil %1 : (tensor<4x9x9xf32>) -> tensor<4x9x9xf32>
    %3 = tosa.minimum %2, %2 : (tensor<4x9x9xf32>, tensor<4x9x9xf32>) -> tensor<4x9x9xf32>
    %cast = tensor.cast %3 : tensor<4x9x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


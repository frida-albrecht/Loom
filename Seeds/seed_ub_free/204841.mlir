module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.390600e+02> : tensor<9x8x3x6xf32>}> : () -> tensor<9x8x3x6xf32>
    %1 = tosa.exp %0 : (tensor<9x8x3x6xf32>) -> tensor<9x8x3x6xf32>
    %2 = tosa.tanh %1 : (tensor<9x8x3x6xf32>) -> tensor<9x8x3x6xf32>
    %3 = tosa.sub %2, %1 : (tensor<9x8x3x6xf32>, tensor<9x8x3x6xf32>) -> tensor<9x8x3x6xf32>
    %4 = tosa.ceil %3 : (tensor<9x8x3x6xf32>) -> tensor<9x8x3x6xf32>
    %5 = tosa.add %4, %1 : (tensor<9x8x3x6xf32>, tensor<9x8x3x6xf32>) -> tensor<9x8x3x6xf32>
    %cast = tensor.cast %5 : tensor<9x8x3x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


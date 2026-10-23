module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.718700e+02> : tensor<4x2xf32>}> : () -> tensor<4x2xf32>
    %1 = "tosa.const"() <{values = dense<-1.188900e+02> : tensor<1x2xf32>}> : () -> tensor<1x2xf32>
    %2 = tosa.pow %0, %1 : (tensor<4x2xf32>, tensor<1x2xf32>) -> tensor<4x2xf32>
    %cast = tensor.cast %2 : tensor<4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


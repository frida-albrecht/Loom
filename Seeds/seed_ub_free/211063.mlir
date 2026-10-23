module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.762900e+02> : tensor<6x3x6xf32>}> : () -> tensor<6x3x6xf32>
    %1 = "tosa.const"() <{values = dense<-1.492300e+02> : tensor<6x3x6xf32>}> : () -> tensor<6x3x6xf32>
    %2 = tosa.minimum %0, %1 : (tensor<6x3x6xf32>, tensor<6x3x6xf32>) -> tensor<6x3x6xf32>
    %cast = tensor.cast %2 : tensor<6x3x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


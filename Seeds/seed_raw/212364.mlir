module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.200600e+02> : tensor<5x6x1xf32>}> : () -> tensor<5x6x1xf32>
    %1 = tosa.ceil %0 : (tensor<5x6x1xf32>) -> tensor<5x6x1xf32>
    %cast = tensor.cast %1 : tensor<5x6x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


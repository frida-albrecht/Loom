module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-98.3099975> : tensor<4x9xf32>}> : () -> tensor<4x9xf32>
    %1 = tosa.floor %0 : (tensor<4x9xf32>) -> tensor<4x9xf32>
    %cast = tensor.cast %1 : tensor<4x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


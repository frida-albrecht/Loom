module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-93.8399963> : tensor<9x3x8xf32>}> : () -> tensor<9x3x8xf32>
    %1 = tosa.ceil %0 : (tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %2 = tosa.pow %1, %1 : (tensor<9x3x8xf32>, tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %cast = tensor.cast %2 : tensor<9x3x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


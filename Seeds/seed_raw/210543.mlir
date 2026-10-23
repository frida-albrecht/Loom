module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.649000e+01> : tensor<6x3x1xf32>}> : () -> tensor<6x3x1xf32>
    %1 = tosa.exp %0 : (tensor<6x3x1xf32>) -> tensor<6x3x1xf32>
    %cast = tensor.cast %1 : tensor<6x3x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


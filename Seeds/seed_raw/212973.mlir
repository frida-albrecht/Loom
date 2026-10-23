module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.865000e+02> : tensor<4x3xf32>}> : () -> tensor<4x3xf32>
    %1 = tosa.log %0 : (tensor<4x3xf32>) -> tensor<4x3xf32>
    %cast = tensor.cast %1 : tensor<4x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


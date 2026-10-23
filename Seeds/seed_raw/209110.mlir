module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.658200e+02> : tensor<8x7xf32>}> : () -> tensor<8x7xf32>
    %1 = tosa.log %0 : (tensor<8x7xf32>) -> tensor<8x7xf32>
    %cast = tensor.cast %1 : tensor<8x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


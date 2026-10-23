module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.469000e+02> : tensor<8x7x8x4xf32>}> : () -> tensor<8x7x8x4xf32>
    %1 = tosa.ceil %0 : (tensor<8x7x8x4xf32>) -> tensor<8x7x8x4xf32>
    %cast = tensor.cast %1 : tensor<8x7x8x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


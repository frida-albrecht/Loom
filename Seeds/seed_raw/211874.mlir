module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.219000e+01> : tensor<3x9x8x3xf32>}> : () -> tensor<3x9x8x3xf32>
    %1 = tosa.exp %0 : (tensor<3x9x8x3xf32>) -> tensor<3x9x8x3xf32>
    %cast = tensor.cast %1 : tensor<3x9x8x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


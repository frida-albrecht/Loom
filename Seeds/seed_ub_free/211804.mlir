module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.668500e+02> : tensor<3x4x8x2xf32>}> : () -> tensor<3x4x8x2xf32>
    %1 = tosa.floor %0 : (tensor<3x4x8x2xf32>) -> tensor<3x4x8x2xf32>
    %2 = tosa.abs %1 : (tensor<3x4x8x2xf32>) -> tensor<3x4x8x2xf32>
    %3 = tosa.floor %2 : (tensor<3x4x8x2xf32>) -> tensor<3x4x8x2xf32>
    %cast = tensor.cast %3 : tensor<3x4x8x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


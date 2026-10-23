module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.688000e+01> : tensor<3x4x6x6xf32>}> : () -> tensor<3x4x6x6xf32>
    %1 = tosa.log %0 : (tensor<3x4x6x6xf32>) -> tensor<3x4x6x6xf32>
    %2 = tosa.log %1 : (tensor<3x4x6x6xf32>) -> tensor<3x4x6x6xf32>
    %cast = tensor.cast %2 : tensor<3x4x6x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


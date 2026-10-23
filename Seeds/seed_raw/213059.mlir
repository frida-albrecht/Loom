module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.061000e+01> : tensor<6x4x6x1xf32>}> : () -> tensor<6x4x6x1xf32>
    %1 = "tosa.const"() <{values = dense<1.148300e+02> : tensor<6x1x6x1xf32>}> : () -> tensor<6x1x6x1xf32>
    %2 = tosa.add %0, %1 : (tensor<6x4x6x1xf32>, tensor<6x1x6x1xf32>) -> tensor<6x4x6x1xf32>
    %cast = tensor.cast %2 : tensor<6x4x6x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


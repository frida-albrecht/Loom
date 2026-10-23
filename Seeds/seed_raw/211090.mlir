module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.620000e+01> : tensor<6x3x10xf32>}> : () -> tensor<6x3x10xf32>
    %1 = "tosa.const"() <{values = dense<-4.921000e+01> : tensor<6x1x10xf32>}> : () -> tensor<6x1x10xf32>
    %2 = tosa.pow %0, %1 : (tensor<6x3x10xf32>, tensor<6x1x10xf32>) -> tensor<6x3x10xf32>
    %3 = tosa.abs %2 : (tensor<6x3x10xf32>) -> tensor<6x3x10xf32>
    %cast = tensor.cast %3 : tensor<6x3x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


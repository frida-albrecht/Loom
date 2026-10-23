module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.344000e+01> : tensor<2x4x5xf32>}> : () -> tensor<2x4x5xf32>
    %1 = "tosa.const"() <{values = dense<-2.670000e+01> : tensor<1x2x3x4x5x6xf32>}> : () -> tensor<1x2x3x4x5x6xf32>
    %2 = "tosa.const"() <{values = dense<-1.132700e+02> : tensor<1x6x2x3x5x4xf32>}> : () -> tensor<1x6x2x3x5x4xf32>
    %broadcasted = linalg.broadcast ins(%0 : tensor<2x4x5xf32>) outs(%1 : tensor<1x2x3x4x5x6xf32>) dimensions = [0, 2, 5] 
    %transposed = linalg.transpose ins(%broadcasted : tensor<1x2x3x4x5x6xf32>) outs(%2 : tensor<1x6x2x3x5x4xf32>) permutation = [0, 5, 1, 2, 4, 3] 
    %cast = tensor.cast %transposed : tensor<1x6x2x3x5x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.107400e+02> : tensor<5x4x3xf32>}> : () -> tensor<5x4x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.522400e+02> : tensor<4x3x5xf32>}> : () -> tensor<4x3x5xf32>
    %2 = "tosa.const"() <{values = dense<9.665000e+01> : tensor<5x4x3xf32>}> : () -> tensor<5x4x3xf32>
    %transposed = linalg.transpose ins(%0 : tensor<5x4x3xf32>) outs(%1 : tensor<4x3x5xf32>) permutation = [1, 2, 0] 
    %transposed_0 = linalg.transpose ins(%transposed : tensor<4x3x5xf32>) outs(%2 : tensor<5x4x3xf32>) permutation = [2, 0, 1] 
    %cast = tensor.cast %transposed_0 : tensor<5x4x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


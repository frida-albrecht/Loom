module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.503000e+01> : tensor<4x210x6xf32>}> : () -> tensor<4x210x6xf32>
    %1 = tensor.empty() : tensor<6x4x210xf32>
    %transposed = linalg.transpose ins(%0 : tensor<4x210x6xf32>) outs(%1 : tensor<6x4x210xf32>) permutation = [2, 0, 1] 
    %expanded = tensor.expand_shape %transposed [[0, 1], [2], [3, 4, 5]] output_shape [2, 3, 4, 5, 6, 7] : tensor<6x4x210xf32> into tensor<2x3x4x5x6x7xf32>
    %cast = tensor.cast %expanded : tensor<2x3x4x5x6x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.638900e+02> : tensor<4x5x6x7x2x3xf32>}> : () -> tensor<4x5x6x7x2x3xf32>
    %1 = tensor.empty() : tensor<6x4x210xf32>
    %collapsed = tensor.collapse_shape %0 [[0], [1, 2, 3], [4, 5]] : tensor<4x5x6x7x2x3xf32> into tensor<4x210x6xf32>
    %transposed = linalg.transpose ins(%collapsed : tensor<4x210x6xf32>) outs(%1 : tensor<6x4x210xf32>) permutation = [2, 0, 1] 
    %cast = tensor.cast %transposed : tensor<6x4x210xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


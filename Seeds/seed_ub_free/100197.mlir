module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x2x3x4xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x2x3x4xf32>) -> tensor<1x2x3x4xf32>
    %collapsed = tensor.collapse_shape %1 [[0, 1, 2], [3]] : tensor<1x2x3x4xf32> into tensor<6x4xf32>
    %cast = tensor.cast %collapsed : tensor<6x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


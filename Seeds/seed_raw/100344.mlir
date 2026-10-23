module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.930000e+00> : tensor<3x2xf32>}> : () -> tensor<3x2xf32>
    %cst = arith.constant dense<[[0.000000e+00, 1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00, 5.000000e+00]]> : tensor<2x3xf32>
    %transposed = linalg.transpose ins(%cst : tensor<2x3xf32>) outs(%0 : tensor<3x2xf32>) permutation = [1, 0] 
    %cast = tensor.cast %transposed : tensor<3x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


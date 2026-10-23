module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.949800e+02> : tensor<16x8x32xf32>}> : () -> tensor<16x8x32xf32>
    %1 = "tosa.const"() <{values = dense<1.758200e+02> : tensor<8x16x32xf32>}> : () -> tensor<8x16x32xf32>
    %2 = tensor.empty() : tensor<8x16x32xf32>
    %transposed = linalg.transpose ins(%0 : tensor<16x8x32xf32>) outs(%2 : tensor<8x16x32xf32>) permutation = [1, 0, 2] 
    %3 = linalg.elementwise kind=#linalg.elementwise_kind<exp> ins(%transposed : tensor<8x16x32xf32>) outs(%1 : tensor<8x16x32xf32>) -> tensor<8x16x32xf32>
    %cast = tensor.cast %3 : tensor<8x16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


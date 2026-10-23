module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.435000e+01> : tensor<2x3x5xf32>}> : () -> tensor<2x3x5xf32>
    %1 = "tosa.const"() <{values = dense<9.916000e+01> : tensor<2x5x7xf32>}> : () -> tensor<2x5x7xf32>
    %2 = "tosa.const"() <{values = dense<1.352900e+02> : tensor<3x7xf32>}> : () -> tensor<3x7xf32>
    %3 = linalg.batch_reduce_matmul ins(%0, %1 : tensor<2x3x5xf32>, tensor<2x5x7xf32>) outs(%2 : tensor<3x7xf32>) -> tensor<3x7xf32>
    %cast = tensor.cast %3 : tensor<3x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


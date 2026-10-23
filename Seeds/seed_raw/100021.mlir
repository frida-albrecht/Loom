module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.019300e+02> : tensor<2x3x5xf32>}> : () -> tensor<2x3x5xf32>
    %1 = "tosa.const"() <{values = dense<1.681100e+02> : tensor<2x5x7xf32>}> : () -> tensor<2x5x7xf32>
    %2 = "tosa.const"() <{values = dense<-4.733000e+01> : tensor<2x3x7xf32>}> : () -> tensor<2x3x7xf32>
    %3 = linalg.batch_matmul ins(%0, %1 : tensor<2x3x5xf32>, tensor<2x5x7xf32>) outs(%2 : tensor<2x3x7xf32>) -> tensor<2x3x7xf32>
    %cast = tensor.cast %3 : tensor<2x3x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


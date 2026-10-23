module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.510000e+01> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %1 = "tosa.const"() <{values = dense<1.679700e+02> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %cst = arith.constant dense<0.000000e+00> : tensor<128x128xf32>
    %2 = linalg.matmul ins(%0, %1 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%cst : tensor<128x128xf32>) -> tensor<128x128xf32>
    %cast = tensor.cast %2 : tensor<128x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


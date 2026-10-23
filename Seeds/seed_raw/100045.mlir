module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.893000e+01> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %1 = "tosa.const"() <{values = dense<96.5599975> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %2 = "tosa.const"() <{values = dense<-5.328000e+01> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<128x128xf32>) -> tensor<128x128xf32>
    %4 = linalg.matmul ins(%0, %1 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%3 : tensor<128x128xf32>) -> tensor<128x128xf32>
    %cast = tensor.cast %4 : tensor<128x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


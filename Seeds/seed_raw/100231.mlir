module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.340000e+00> : tensor<16x8xf32>}> : () -> tensor<16x8xf32>
    %1 = "tosa.const"() <{values = dense<1.608500e+02> : tensor<8x32xf32>}> : () -> tensor<8x32xf32>
    %2 = "tosa.const"() <{values = dense<-6.624000e+01> : tensor<16x32xf32>}> : () -> tensor<16x32xf32>
    %3 = linalg.matmul ins(%0, %1 : tensor<16x8xf32>, tensor<8x32xf32>) outs(%2 : tensor<16x32xf32>) -> tensor<16x32xf32>
    %cast = tensor.cast %3 : tensor<16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


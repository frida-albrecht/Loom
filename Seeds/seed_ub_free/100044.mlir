module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.079000e+01> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %1 = "tosa.const"() <{values = dense<6.105000e+01> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %2 = "tosa.const"() <{values = dense<-1.657000e+02> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %3 = "tosa.const"() <{values = dense<-1.157900e+02> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %4 = tensor.empty() : tensor<128x128xf32>
    %5 = linalg.matmul ins(%0, %1 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%2 : tensor<128x128xf32>) -> tensor<128x128xf32>
    %6 = linalg.add ins(%5, %3 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%4 : tensor<128x128xf32>) -> tensor<128x128xf32>
    %cast = tensor.cast %6 : tensor<128x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


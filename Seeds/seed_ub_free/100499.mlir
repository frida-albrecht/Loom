module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.054000e+01> : tensor<1x128x512xf32>}> : () -> tensor<1x128x512xf32>
    %1 = "tosa.const"() <{values = dense<-1.700900e+02> : tensor<1x512xf32>}> : () -> tensor<1x512xf32>
    %2 = "tosa.const"() <{values = dense<-2.939000e+01> : tensor<1x128xf32>}> : () -> tensor<1x128xf32>
    %3 = linalg.batch_matvec ins(%0, %1 : tensor<1x128x512xf32>, tensor<1x512xf32>) outs(%2 : tensor<1x128xf32>) -> tensor<1x128xf32>
    %cast = tensor.cast %3 : tensor<1x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


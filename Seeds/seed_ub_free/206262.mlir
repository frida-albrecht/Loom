module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.246000e+01> : tensor<10x2x10xf32>}> : () -> tensor<10x2x10xf32>
    %1 = "tosa.const"() <{values = dense<-1.244400e+02> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %2 = tosa.sub %0, %1 : (tensor<10x2x10xf32>, tensor<1x1x1xf32>) -> tensor<10x2x10xf32>
    %cast = tensor.cast %2 : tensor<10x2x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.135000e+01> : tensor<1x2x6x9xf32>}> : () -> tensor<1x2x6x9xf32>
    %1 = "tosa.const"() <{values = dense<-89.8399963> : tensor<1x2x1x9xf32>}> : () -> tensor<1x2x1x9xf32>
    %2 = tosa.add %0, %1 : (tensor<1x2x6x9xf32>, tensor<1x2x1x9xf32>) -> tensor<1x2x6x9xf32>
    %3 = tosa.minimum %2, %2 : (tensor<1x2x6x9xf32>, tensor<1x2x6x9xf32>) -> tensor<1x2x6x9xf32>
    %4 = tosa.floor %3 : (tensor<1x2x6x9xf32>) -> tensor<1x2x6x9xf32>
    %cast = tensor.cast %4 : tensor<1x2x6x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


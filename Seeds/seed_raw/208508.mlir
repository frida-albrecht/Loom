module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.499000e+02> : tensor<8x10x9xf32>}> : () -> tensor<8x10x9xf32>
    %1 = "tosa.const"() <{values = dense<-3.838000e+01> : tensor<1x10x1xf32>}> : () -> tensor<1x10x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<8x10x9xf32>, tensor<1x10x1xf32>) -> tensor<8x10x9xf32>
    %cast = tensor.cast %2 : tensor<8x10x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


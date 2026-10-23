module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.170000e+00> : tensor<10x2xf32>}> : () -> tensor<10x2xf32>
    %1 = tosa.reciprocal %0 : (tensor<10x2xf32>) -> tensor<10x2xf32>
    %cast = tensor.cast %1 : tensor<10x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


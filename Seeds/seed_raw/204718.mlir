module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.374000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<-1.690000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = tosa.minimum %0, %1 : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %cast = tensor.cast %2 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


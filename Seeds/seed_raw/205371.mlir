module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.500000e+00> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.negate %0, %1, %2 : (tensor<7x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<7x4xf32>
    %4 = tosa.maximum %3, %3 : (tensor<7x4xf32>, tensor<7x4xf32>) -> tensor<7x4xf32>
    %cast = tensor.cast %4 : tensor<7x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


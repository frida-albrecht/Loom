module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.380000e+00> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = tosa.exp %0 : (tensor<2xf32>) -> tensor<2xf32>
    %2 = tosa.maximum %1, %1 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<2xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2xf32>
    %cast = tensor.cast %5 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


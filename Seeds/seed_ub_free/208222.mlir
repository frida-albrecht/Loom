module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.171000e+01> : tensor<4x1x5xf32>}> : () -> tensor<4x1x5xf32>
    %1 = "tosa.const"() <{values = dense<3.876000e+01> : tensor<4x1x1xf32>}> : () -> tensor<4x1x1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<4x1x5xf32>, tensor<4x1x1xf32>) -> tensor<4x1x5xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<4x1x5xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x1x5xf32>
    %6 = tosa.tanh %5 : (tensor<4x1x5xf32>) -> tensor<4x1x5xf32>
    %cast = tensor.cast %6 : tensor<4x1x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


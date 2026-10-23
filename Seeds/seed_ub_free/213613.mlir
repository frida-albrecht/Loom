module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-61.9199981> : tensor<2x1xf32>}> : () -> tensor<2x1xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.negate %0, %1, %2 : (tensor<2x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x1xf32>
    %4 = tosa.add %3, %3 : (tensor<2x1xf32>, tensor<2x1xf32>) -> tensor<2x1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = tosa.negate %4, %5, %6 : (tensor<2x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x1xf32>
    %cast = tensor.cast %7 : tensor<2x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


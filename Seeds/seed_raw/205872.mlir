module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.361000e+01> : tensor<6x5x1xf32>}> : () -> tensor<6x5x1xf32>
    %1 = "tosa.const"() <{values = dense<1.123400e+02> : tensor<6x1x4xf32>}> : () -> tensor<6x1x4xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<6x5x1xf32>, tensor<6x1x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<6x5x4xf32>
    %5 = tosa.tanh %4 : (tensor<6x5x4xf32>) -> tensor<6x5x4xf32>
    %cast = tensor.cast %5 : tensor<6x5x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


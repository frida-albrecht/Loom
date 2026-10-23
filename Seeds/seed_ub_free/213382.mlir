module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.645000e+01> : tensor<10x10x3xf32>}> : () -> tensor<10x10x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.336700e+02> : tensor<10x3x1xf32>}> : () -> tensor<10x3x1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<10x10x3xf32>, tensor<10x3x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<10x10x1xf32>
    %cast = tensor.cast %4 : tensor<10x10x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


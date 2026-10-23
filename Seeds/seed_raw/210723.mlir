module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.441900e+02> : tensor<4x3x8xf32>}> : () -> tensor<4x3x8xf32>
    %1 = "tosa.const"() <{values = dense<-1.231300e+02> : tensor<4x8x9xf32>}> : () -> tensor<4x8x9xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<4x3x8xf32>, tensor<4x8x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x3x9xf32>
    %cast = tensor.cast %4 : tensor<4x3x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.718700e+02> : tensor<4x2xf32>}> : () -> tensor<4x2xf32>
    %1 = "tosa.const"() <{values = dense<-1.188900e+02> : tensor<1x2xf32>}> : () -> tensor<1x2xf32>
    %c1 = "tosa.const"() <{values = dense<0.0> : tensor<4x2xf32>}> : () -> tensor<4x2xf32>
    %a2 = tosa.maximum %0, %c1 : (tensor<4x2xf32>, tensor<4x2xf32>) -> tensor<4x2xf32>
    %c3 = "tosa.const"() <{values = dense<1.0> : tensor<1x2xf32>}> : () -> tensor<1x2xf32>
    %a4 = tosa.maximum %1, %c3 : (tensor<1x2xf32>, tensor<1x2xf32>) -> tensor<1x2xf32>
    %2 = tosa.pow %a2, %a4 : (tensor<4x2xf32>, tensor<1x2xf32>) -> tensor<4x2xf32>
    %cast = tensor.cast %2 : tensor<4x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
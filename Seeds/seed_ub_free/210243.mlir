module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-93.8399963> : tensor<9x3x8xf32>}> : () -> tensor<9x3x8xf32>
    %1 = tosa.ceil %0 : (tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<9x3x8xf32>}> : () -> tensor<9x3x8xf32>
    %a0 = tosa.maximum %1, %c0 : (tensor<9x3x8xf32>, tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<9x3x8xf32>}> : () -> tensor<9x3x8xf32>
    %a1 = tosa.maximum %1, %c1 : (tensor<9x3x8xf32>, tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %2 = tosa.pow %a0, %a1 : (tensor<9x3x8xf32>, tensor<9x3x8xf32>) -> tensor<9x3x8xf32>
    %cast = tensor.cast %2 : tensor<9x3x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}
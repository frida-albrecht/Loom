module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-153> : tensor<5x1x5x2xi32>}> : () -> tensor<5x1x5x2xi32>
    %1 = "tosa.const"() <{values = dense<-139> : tensor<5x1x1x1xi32>}> : () -> tensor<5x1x1x1xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x1x1x1xi32>}> : () -> tensor<5x1x1x1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<5x1x1x1xi32>}> : () -> tensor<5x1x1x1xi32>
    %a1 = tosa.maximum %1, %c0 : (tensor<5x1x1x1xi32>, tensor<5x1x1x1xi32>) -> tensor<5x1x1x1xi32>
    %a2 = tosa.minimum %a1, %c31 : (tensor<5x1x1x1xi32>, tensor<5x1x1x1xi32>) -> tensor<5x1x1x1xi32>
    %2 = tosa.arithmetic_right_shift %0, %a2 {round = true} : (tensor<5x1x5x2xi32>, tensor<5x1x1x1xi32>) -> tensor<5x1x5x2xi32>
    %cast = tensor.cast %2 : tensor<5x1x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
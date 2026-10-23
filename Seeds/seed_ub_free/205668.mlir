module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-87> : tensor<6x10x2xi32>}> : () -> tensor<6x10x2xi32>
    %1 = "tosa.const"() <{values = dense<175> : tensor<6x1x2xi32>}> : () -> tensor<6x1x2xi32>
    %c2 = "tosa.const"() <{values = dense<0> : tensor<6x1x2xi32>}> : () -> tensor<6x1x2xi32>
    %c3 = "tosa.const"() <{values = dense<31> : tensor<6x1x2xi32>}> : () -> tensor<6x1x2xi32>
    %c4 = tosa.maximum %1, %c2 : (tensor<6x1x2xi32>, tensor<6x1x2xi32>) -> tensor<6x1x2xi32>
    %c5 = tosa.minimum %c4, %c3 : (tensor<6x1x2xi32>, tensor<6x1x2xi32>) -> tensor<6x1x2xi32>
    %2 = tosa.logical_right_shift %0, %c5 : (tensor<6x10x2xi32>, tensor<6x1x2xi32>) -> tensor<6x10x2xi32>
    %3 = tosa.bitwise_and %2, %2 : (tensor<6x10x2xi32>, tensor<6x10x2xi32>) -> tensor<6x10x2xi32>
    %cast = tensor.cast %3 : tensor<6x10x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
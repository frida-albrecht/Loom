module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89> : tensor<6x3x5x2xi32>}> : () -> tensor<6x3x5x2xi32>
    %1 = "tosa.const"() <{values = dense<-120> : tensor<1x3x5x2xi32>}> : () -> tensor<1x3x5x2xi32>
    %2 = tosa.maximum %0, %1 : (tensor<6x3x5x2xi32>, tensor<1x3x5x2xi32>) -> tensor<6x3x5x2xi32>
    %cast = tensor.cast %2 : tensor<6x3x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


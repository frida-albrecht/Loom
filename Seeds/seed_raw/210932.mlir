module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-192> : tensor<6x1x10x2xi32>}> : () -> tensor<6x1x10x2xi32>
    %1 = "tosa.const"() <{values = dense<95> : tensor<6x1x10x2xi32>}> : () -> tensor<6x1x10x2xi32>
    %2 = tosa.bitwise_or %0, %1 : (tensor<6x1x10x2xi32>, tensor<6x1x10x2xi32>) -> tensor<6x1x10x2xi32>
    %cast = tensor.cast %2 : tensor<6x1x10x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-17> : tensor<3x2x2xi32>}> : () -> tensor<3x2x2xi32>
    %1 = "tosa.const"() <{values = dense<-143> : tensor<1x2x2xi32>}> : () -> tensor<1x2x2xi32>
    %2 = tosa.bitwise_or %0, %1 : (tensor<3x2x2xi32>, tensor<1x2x2xi32>) -> tensor<3x2x2xi32>
    %cast = tensor.cast %2 : tensor<3x2x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


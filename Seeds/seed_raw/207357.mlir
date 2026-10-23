module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<106> : tensor<2xi32>}> : () -> tensor<2xi32>
    %1 = "tosa.const"() <{values = dense<-191> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.maximum %0, %1 : (tensor<2xi32>, tensor<1xi32>) -> tensor<2xi32>
    %3 = tosa.clz %2 : (tensor<2xi32>) -> tensor<2xi32>
    %4 = tosa.add %3, %2 : (tensor<2xi32>, tensor<2xi32>) -> tensor<2xi32>
    %cast = tensor.cast %4 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


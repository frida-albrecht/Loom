module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %1 = "tosa.const"() <{values = dense<-38> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<6x1xi32>, tensor<1x1xi32>) -> tensor<6x1xi32>
    %cast = tensor.cast %2 : tensor<6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


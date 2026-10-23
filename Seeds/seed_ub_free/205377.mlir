module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<151> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<-167> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<8xi32>, tensor<1xi32>) -> tensor<8xi32>
    %cast = tensor.cast %2 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


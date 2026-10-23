module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-184> : tensor<5x7x6x1xi32>}> : () -> tensor<5x7x6x1xi32>
    %1 = "tosa.const"() <{values = dense<162> : tensor<1x1x6x1xi32>}> : () -> tensor<1x1x6x1xi32>
    %2 = tosa.add %0, %1 : (tensor<5x7x6x1xi32>, tensor<1x1x6x1xi32>) -> tensor<5x7x6x1xi32>
    %3 = tosa.bitwise_not %2 : (tensor<5x7x6x1xi32>) -> tensor<5x7x6x1xi32>
    %cast = tensor.cast %3 : tensor<5x7x6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


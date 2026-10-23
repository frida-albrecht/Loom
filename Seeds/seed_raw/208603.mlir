module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-65> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<90> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.bitwise_or %0, %1 : (tensor<4xi32>, tensor<1xi32>) -> tensor<4xi32>
    %cast = tensor.cast %2 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


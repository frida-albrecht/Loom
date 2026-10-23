module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<141> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<-42> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.bitwise_or %0, %1 : (tensor<4xi32>, tensor<1xi32>) -> tensor<4xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.negate %2, %3, %4 : (tensor<4xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<4xi32>
    %cast = tensor.cast %5 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<106> : tensor<10x2xi32>}> : () -> tensor<10x2xi32>
    %1 = "tosa.const"() <{values = dense<179> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<10x2xi32>, tensor<1x1xi32>) -> tensor<10x2xi32>
    %cast = tensor.cast %2 : tensor<10x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


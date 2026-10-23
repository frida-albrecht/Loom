module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-48> : tensor<7x4xi32>}> : () -> tensor<7x4xi32>
    %1 = "tosa.const"() <{values = dense<25> : tensor<7x4xi32>}> : () -> tensor<7x4xi32>
    %2 = tosa.bitwise_and %0, %1 : (tensor<7x4xi32>, tensor<7x4xi32>) -> tensor<7x4xi32>
    %cast = tensor.cast %2 : tensor<7x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


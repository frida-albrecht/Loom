module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-14> : tensor<10x5x4xi32>}> : () -> tensor<10x5x4xi32>
    %1 = "tosa.const"() <{values = dense<115> : tensor<10x5x1xi32>}> : () -> tensor<10x5x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<10x5x4xi32>, tensor<10x5x1xi32>) -> tensor<10x5x4xi32>
    %3 = tosa.sub %2, %2 : (tensor<10x5x4xi32>, tensor<10x5x4xi32>) -> tensor<10x5x4xi32>
    %cast = tensor.cast %3 : tensor<10x5x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


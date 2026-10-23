module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-92> : tensor<10x4x4x4xi32>}> : () -> tensor<10x4x4x4xi32>
    %1 = "tosa.const"() <{values = dense<65> : tensor<1x4x4x4xi32>}> : () -> tensor<1x4x4x4xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<10x4x4x4xi32>, tensor<1x4x4x4xi32>) -> tensor<10x4x4x4xi32>
    %3 = tosa.clz %2 : (tensor<10x4x4x4xi32>) -> tensor<10x4x4x4xi32>
    %cast = tensor.cast %3 : tensor<10x4x4x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


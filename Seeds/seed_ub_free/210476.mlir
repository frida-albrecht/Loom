module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-151> : tensor<8x4x9x4xi32>}> : () -> tensor<8x4x9x4xi32>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<1x4x9x1xi32>}> : () -> tensor<1x4x9x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<8x4x9x4xi32>, tensor<1x4x9x1xi32>) -> tensor<8x4x9x4xi32>
    %3 = tosa.bitwise_not %2 : (tensor<8x4x9x4xi32>) -> tensor<8x4x9x4xi32>
    %cast = tensor.cast %3 : tensor<8x4x9x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


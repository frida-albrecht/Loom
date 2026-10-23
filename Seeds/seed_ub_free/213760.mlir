module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-179> : tensor<8x2x9xi32>}> : () -> tensor<8x2x9xi32>
    %1 = "tosa.const"() <{values = dense<43> : tensor<8x9x2xi32>}> : () -> tensor<8x9x2xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<8x2x9xi32>, tensor<8x9x2xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<8x2x2xi32>
    %cast = tensor.cast %4 : tensor<8x2x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


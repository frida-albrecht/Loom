module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-53> : tensor<10x7x7xi32>}> : () -> tensor<10x7x7xi32>
    %1 = "tosa.const"() <{values = dense<57> : tensor<10x7x10xi32>}> : () -> tensor<10x7x10xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<10x7x7xi32>, tensor<10x7x10xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<10x7x10xi32>
    %cast = tensor.cast %4 : tensor<10x7x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


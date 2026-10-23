module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73> : tensor<10x7x10xi32>}> : () -> tensor<10x7x10xi32>
    %1 = "tosa.const"() <{values = dense<189> : tensor<10x10x4xi32>}> : () -> tensor<10x10x4xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<10x7x10xi32>, tensor<10x10x4xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<10x7x4xi32>
    %5 = tosa.abs %4 : (tensor<10x7x4xi32>) -> tensor<10x7x4xi32>
    %cast = tensor.cast %5 : tensor<10x7x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<116> : tensor<9x5x3xi32>}> : () -> tensor<9x5x3xi32>
    %1 = "tosa.const"() <{values = dense<-85> : tensor<9x3x2xi32>}> : () -> tensor<9x3x2xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<9x5x3xi32>, tensor<9x3x2xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9x5x2xi32>
    %cast = tensor.cast %4 : tensor<9x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


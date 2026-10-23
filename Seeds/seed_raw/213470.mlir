module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.643800e+02> : tensor<10x3x3x5xf32>}> : () -> tensor<10x3x3x5xf32>
    %1 = "tosa.const"() <{values = dense<-92> : tensor<10xi32>}> : () -> tensor<10xi32>
    %2 = "tosa.const"() <{values = dense<-128> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.exp %0 : (tensor<10x3x3x5xf32>) -> tensor<10x3x3x5xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<10xi32>, tensor<1xi32>) -> tensor<10xi32>
    %5 = tosa.rsqrt %3 : (tensor<10x3x3x5xf32>) -> tensor<10x3x3x5xf32>
    %cast = tensor.cast %4 : tensor<10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<10x3x3x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


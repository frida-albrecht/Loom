module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-167> : tensor<3x6x7xi32>}> : () -> tensor<3x6x7xi32>
    %1 = "tosa.const"() <{values = dense<83> : tensor<3x7x5xi32>}> : () -> tensor<3x7x5xi32>
    %2 = "tosa.const"() <{values = dense<-1.363400e+02> : tensor<1x10x5xf32>}> : () -> tensor<1x10x5xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<3x6x7xi32>, tensor<3x7x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<3x6x5xi32>
    %6 = tosa.tanh %2 : (tensor<1x10x5xf32>) -> tensor<1x10x5xf32>
    %cast = tensor.cast %5 : tensor<3x6x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<1x10x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<6x1x7x4xi32>}> : () -> tensor<6x1x7x4xi32>
    %1 = "tosa.const"() <{values = dense<7> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %2 = "tosa.const"() <{values = dense<7.099000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %3 = "tosa.const"() <{values = dense<-1.733600e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.bitwise_or %0, %1 : (tensor<6x1x7x4xi32>, tensor<1x1x1x1xi32>) -> tensor<6x1x7x4xi32>
    %5 = tosa.pow %2, %3 : (tensor<7xf32>, tensor<1xf32>) -> tensor<7xf32>
    %cast = tensor.cast %4 : tensor<6x1x7x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


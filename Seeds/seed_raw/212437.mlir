module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.285000e+01> : tensor<7x6xf32>}> : () -> tensor<7x6xf32>
    %1 = "tosa.const"() <{values = dense<162> : tensor<6x3x2x6xi32>}> : () -> tensor<6x3x2x6xi32>
    %2 = "tosa.const"() <{values = dense<-88> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<7x6xf32>) -> tensor<7x6xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<6x3x2x6xi32>, tensor<1x1x1x1xi32>) -> tensor<6x3x2x6xi32>
    %5 = tosa.clz %4 : (tensor<6x3x2x6xi32>) -> tensor<6x3x2x6xi32>
    %cast = tensor.cast %3 : tensor<7x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x3x2x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


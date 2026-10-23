module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<119> : tensor<3x6xi32>}> : () -> tensor<3x6xi32>
    %1 = "tosa.const"() <{values = dense<-108> : tensor<1x6xi32>}> : () -> tensor<1x6xi32>
    %2 = "tosa.const"() <{values = dense<1.275700e+02> : tensor<5x3xf32>}> : () -> tensor<5x3xf32>
    %3 = "tosa.const"() <{values = dense<1.443100e+02> : tensor<1x3xf32>}> : () -> tensor<1x3xf32>
    %4 = tosa.intdiv %0, %1 : (tensor<3x6xi32>, tensor<1x6xi32>) -> tensor<3x6xi32>
    %5 = tosa.minimum %4, %4 : (tensor<3x6xi32>, tensor<3x6xi32>) -> tensor<3x6xi32>
    %6 = tosa.pow %2, %3 : (tensor<5x3xf32>, tensor<1x3xf32>) -> tensor<5x3xf32>
    %7 = tosa.bitwise_or %5, %4 : (tensor<3x6xi32>, tensor<3x6xi32>) -> tensor<3x6xi32>
    %cast = tensor.cast %6 : tensor<5x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<3x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-139> : tensor<1x6x6x10xi16>}> : () -> tensor<1x6x6x10xi16>
    %1 = "tosa.const"() <{values = dense<-1.208300e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = tosa.argmax %0 {axis = 2 : i32} : (tensor<1x6x6x10xi16>) -> tensor<1x6x10xi32>
    %3 = tosa.concat %2, %2 {axis = 2 : i32} : (tensor<1x6x10xi32>, tensor<1x6x10xi32>) -> tensor<1x6x20xi32>
    %4 = tosa.floor %1 : (tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.logical_right_shift %3, %3 : (tensor<1x6x20xi32>, tensor<1x6x20xi32>) -> tensor<1x6x20xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = tosa.negate %5, %6, %7 : (tensor<1x6x20xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x6x20xi32>
    %9 = tosa.bitwise_or %8, %8 : (tensor<1x6x20xi32>, tensor<1x6x20xi32>) -> tensor<1x6x20xi32>
    %cast = tensor.cast %4 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<1x6x20xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


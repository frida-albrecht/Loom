module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.848700e+02> : tensor<6x8x2xf32>}> : () -> tensor<6x8x2xf32>
    %1 = "tosa.const"() <{values = dense<158> : tensor<2x10xi32>}> : () -> tensor<2x10xi32>
    %2 = "tosa.const"() <{values = dense<187> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %3 = tosa.ceil %0 : (tensor<6x8x2xf32>) -> tensor<6x8x2xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<2x10xi32>, tensor<1x1xi32>) -> tensor<2x10xi32>
    %cast = tensor.cast %3 : tensor<6x8x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<2x10xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


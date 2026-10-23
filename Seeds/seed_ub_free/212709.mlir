module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.867000e+01> : tensor<1x6x2xf32>}> : () -> tensor<1x6x2xf32>
    %1 = "tosa.const"() <{values = dense<185> : tensor<9x3xi32>}> : () -> tensor<9x3xi32>
    %2 = "tosa.const"() <{values = dense<92> : tensor<9x1xi32>}> : () -> tensor<9x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<1x6x2xf32>) -> tensor<1x6x2xf32>
    %4 = tosa.reciprocal %3 : (tensor<1x6x2xf32>) -> tensor<1x6x2xf32>
    %5 = tosa.bitwise_or %1, %2 : (tensor<9x3xi32>, tensor<9x1xi32>) -> tensor<9x3xi32>
    %cast = tensor.cast %4 : tensor<1x6x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<9x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<132> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = "tosa.const"() <{values = dense<-16> : tensor<3xi32>}> : () -> tensor<3xi32>
    %2 = "tosa.const"() <{values = dense<-1.235200e+02> : tensor<4x8x7x10xf32>}> : () -> tensor<4x8x7x10xf32>
    %3 = tosa.intdiv %0, %1 : (tensor<3xi32>, tensor<3xi32>) -> tensor<3xi32>
    %4 = tosa.exp %2 : (tensor<4x8x7x10xf32>) -> tensor<4x8x7x10xf32>
    %cast = tensor.cast %3 : tensor<3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<4x8x7x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


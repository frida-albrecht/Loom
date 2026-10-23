module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-180> : tensor<4x9x4xi32>}> : () -> tensor<4x9x4xi32>
    %1 = "tosa.const"() <{values = dense<170> : tensor<1x9x4xi32>}> : () -> tensor<1x9x4xi32>
    %2 = "tosa.const"() <{values = dense<1.945300e+02> : tensor<6x4x10xf32>}> : () -> tensor<6x4x10xf32>
    %3 = tosa.maximum %0, %1 : (tensor<4x9x4xi32>, tensor<1x9x4xi32>) -> tensor<4x9x4xi32>
    %4 = tosa.tanh %2 : (tensor<6x4x10xf32>) -> tensor<6x4x10xf32>
    %cast = tensor.cast %3 : tensor<4x9x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<6x4x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


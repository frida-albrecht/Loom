module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<117> : tensor<9xi32>}> : () -> tensor<9xi32>
    %1 = "tosa.const"() <{values = dense<109> : tensor<9xi32>}> : () -> tensor<9xi32>
    %2 = "tosa.const"() <{values = dense<6.313000e+01> : tensor<4x10x1xf32>}> : () -> tensor<4x10x1xf32>
    %3 = tosa.maximum %0, %1 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %4 = tosa.sigmoid %2 : (tensor<4x10x1xf32>) -> tensor<4x10x1xf32>
    %5 = tosa.rsqrt %4 : (tensor<4x10x1xf32>) -> tensor<4x10x1xf32>
    %cast = tensor.cast %3 : tensor<9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<4x10x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.305800e+02> : tensor<4x10xf32>}> : () -> tensor<4x10xf32>
    %1 = "tosa.const"() <{values = dense<8.825000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = tosa.sub %0, %1 : (tensor<4x10xf32>, tensor<1x1xf32>) -> tensor<4x10xf32>
    %3 = tosa.ceil %2 : (tensor<4x10xf32>) -> tensor<4x10xf32>
    %cast = tensor.cast %3 : tensor<4x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


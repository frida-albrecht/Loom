module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.565800e+02> : tensor<4x6x8xf32>}> : () -> tensor<4x6x8xf32>
    %1 = "tosa.const"() <{values = dense<4.002000e+01> : tensor<1x6x8xf32>}> : () -> tensor<1x6x8xf32>
    %2 = tosa.pow %0, %1 : (tensor<4x6x8xf32>, tensor<1x6x8xf32>) -> tensor<4x6x8xf32>
    %3 = tosa.minimum %2, %2 : (tensor<4x6x8xf32>, tensor<4x6x8xf32>) -> tensor<4x6x8xf32>
    %4 = tosa.log %3 : (tensor<4x6x8xf32>) -> tensor<4x6x8xf32>
    %cast = tensor.cast %4 : tensor<4x6x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.851000e+01> : tensor<4x5x5xf32>}> : () -> tensor<4x5x5xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.negate %0, %1, %2 : (tensor<4x5x5xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x5x5xf32>
    %cast = tensor.cast %3 : tensor<4x5x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


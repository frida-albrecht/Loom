module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.634100e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<9.510000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pow %0, %1 : (tensor<4xf32>, tensor<1xf32>) -> tensor<4xf32>
    %cast = tensor.cast %2 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


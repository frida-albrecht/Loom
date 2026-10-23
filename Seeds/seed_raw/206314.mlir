module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.316000e+01> : tensor<5x7x4xf32>}> : () -> tensor<5x7x4xf32>
    %1 = tosa.abs %0 : (tensor<5x7x4xf32>) -> tensor<5x7x4xf32>
    %2 = tosa.exp %1 : (tensor<5x7x4xf32>) -> tensor<5x7x4xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<5x7x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<5x7x4xf32>
    %6 = tosa.rsqrt %5 : (tensor<5x7x4xf32>) -> tensor<5x7x4xf32>
    %cast = tensor.cast %6 : tensor<5x7x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.743000e+01> : tensor<1x7x1xf32>}> : () -> tensor<1x7x1xf32>
    %1 = tosa.reciprocal %0 : (tensor<1x7x1xf32>) -> tensor<1x7x1xf32>
    %2 = tosa.add %1, %1 : (tensor<1x7x1xf32>, tensor<1x7x1xf32>) -> tensor<1x7x1xf32>
    %3 = tosa.sub %2, %2 : (tensor<1x7x1xf32>, tensor<1x7x1xf32>) -> tensor<1x7x1xf32>
    %cast = tensor.cast %3 : tensor<1x7x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


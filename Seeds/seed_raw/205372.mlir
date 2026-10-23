module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.351400e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.rsqrt %0 : (tensor<1xf32>) -> tensor<1xf32>
    %2 = tosa.abs %1 : (tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.maximum %2, %2 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.negate %3, %4, %5 : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


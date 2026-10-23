module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.018000e+01> : tensor<7x2x4xf32>}> : () -> tensor<7x2x4xf32>
    %1 = tosa.sigmoid %0 : (tensor<7x2x4xf32>) -> tensor<7x2x4xf32>
    %2 = tosa.sigmoid %1 : (tensor<7x2x4xf32>) -> tensor<7x2x4xf32>
    %3 = tosa.rsqrt %2 : (tensor<7x2x4xf32>) -> tensor<7x2x4xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.negate %3, %4, %5 : (tensor<7x2x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<7x2x4xf32>
    %cast = tensor.cast %6 : tensor<7x2x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


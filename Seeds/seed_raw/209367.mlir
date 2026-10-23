module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.043000e+01> : tensor<1x4xf32>}> : () -> tensor<1x4xf32>
    %1 = "tosa.const"() <{values = dense<4.488000e+01> : tensor<1x4xf32>}> : () -> tensor<1x4xf32>
    %2 = tosa.maximum %0, %1 : (tensor<1x4xf32>, tensor<1x4xf32>) -> tensor<1x4xf32>
    %3 = tosa.clamp %2 {max_val = 1.310000e+02 : f32, min_val = 2.100000e+01 : f32} : (tensor<1x4xf32>) -> tensor<1x4xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.negate %3, %4, %5 : (tensor<1x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x4xf32>
    %7 = tosa.rsqrt %6 : (tensor<1x4xf32>) -> tensor<1x4xf32>
    %8 = tosa.identity %7 : (tensor<1x4xf32>) -> tensor<1x4xf32>
    %cast = tensor.cast %8 : tensor<1x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


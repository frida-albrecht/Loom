module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.979300e+02> : tensor<1x7x3x4xf32>}> : () -> tensor<1x7x3x4xf32>
    %1 = "tosa.const"() <{values = dense<56> : tensor<3x4x4xi32>}> : () -> tensor<3x4x4xi32>
    %2 = "tosa.const"() <{values = dense<32> : tensor<1x1x1xi32>}> : () -> tensor<1x1x1xi32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %0, %3, %4 : (tensor<1x7x3x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x7x3x4xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<3x4x4xi32>, tensor<1x1x1xi32>) -> tensor<3x4x4xi32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<1x7x3x4xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1x7x3x4xf32>
    %10 = tosa.bitwise_or %6, %6 : (tensor<3x4x4xi32>, tensor<3x4x4xi32>) -> tensor<3x4x4xi32>
    %cast = tensor.cast %9 : tensor<1x7x3x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<3x4x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


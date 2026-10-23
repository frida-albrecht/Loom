module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.345000e+01> : tensor<4x5xf32>}> : () -> tensor<4x5xf32>
    %1 = "tosa.const"() <{values = dense<76> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.pad %0, %2, %3 : (tensor<4x5xf32>, !tosa.shape<4>, tensor<1xf32>) -> tensor<4x5xf32>
    %cast = tensor.cast %4 : tensor<4x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


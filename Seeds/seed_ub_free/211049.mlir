module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.528000e+01> : tensor<3x8x3xf32>}> : () -> tensor<3x8x3xf32>
    %1 = "tosa.const"() <{values = dense<1.463700e+02> : tensor<3x3x8xf32>}> : () -> tensor<3x3x8xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<3x8x3xf32>, tensor<3x3x8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<3x8x8xf32>
    %5 = tosa.maximum %4, %4 : (tensor<3x8x8xf32>, tensor<3x8x8xf32>) -> tensor<3x8x8xf32>
    %6 = tosa.const_shape  {values = dense<[48, 2, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %5, %6 : (tensor<3x8x8xf32>, !tosa.shape<3>) -> tensor<48x2x2xf32>
    %cast = tensor.cast %7 : tensor<48x2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


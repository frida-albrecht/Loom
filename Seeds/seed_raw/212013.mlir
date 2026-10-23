module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.872500e+02> : tensor<2x7xf32>}> : () -> tensor<2x7xf32>
    %1 = tosa.log %0 : (tensor<2x7xf32>) -> tensor<2x7xf32>
    %2 = tosa.sigmoid %1 : (tensor<2x7xf32>) -> tensor<2x7xf32>
    %3 = tosa.const_shape  {values = dense<[2, 7]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<2x7xf32>, !tosa.shape<2>) -> tensor<2x7xf32>
    %5 = tosa.maximum %4, %1 : (tensor<2x7xf32>, tensor<2x7xf32>) -> tensor<2x7xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = tosa.negate %5, %6, %7 : (tensor<2x7xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x7xf32>
    %cast = tensor.cast %8 : tensor<2x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.007000e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<23> : tensor<6xi64>}> : () -> tensor<6xi64>
    %2 = "tosa.const"() <{values = dense<-16> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.tanh %0 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.rsqrt %3 : (tensor<3xf32>) -> tensor<3xf32>
    %5 = tosa.arithmetic_right_shift %1, %2 {round = true} : (tensor<6xi64>, tensor<1xi64>) -> tensor<6xi64>
    %6 = tosa.logical_right_shift %5, %5 : (tensor<6xi64>, tensor<6xi64>) -> tensor<6xi64>
    %7 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %8 = tosa.reshape %6, %7 : (tensor<6xi64>, !tosa.shape<2>) -> tensor<2x3xi64>
    %cast = tensor.cast %4 : tensor<3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x3xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


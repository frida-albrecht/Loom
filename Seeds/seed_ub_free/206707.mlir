module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<175> : tensor<1x3x4x1xi64>}> : () -> tensor<1x3x4x1xi64>
    %1 = "tosa.const"() <{values = dense<-86> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %2 = "tosa.const"() <{values = dense<-1.788400e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<1x3x4x1xi64>, tensor<1x1x1x1xi64>) -> tensor<1x3x4x1xi64>
    %4 = tosa.bitwise_and %3, %3 : (tensor<1x3x4x1xi64>, tensor<1x3x4x1xi64>) -> tensor<1x3x4x1xi64>
    %5 = tosa.maximum %4, %3 : (tensor<1x3x4x1xi64>, tensor<1x3x4x1xi64>) -> tensor<1x3x4x1xi64>
    %6 = tosa.sigmoid %2 : (tensor<6xf32>) -> tensor<6xf32>
    %7 = tosa.const_shape  {values = dense<[2, 6, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %8 = tosa.reshape %5, %7 : (tensor<1x3x4x1xi64>, !tosa.shape<3>) -> tensor<2x6x1xi64>
    %cast = tensor.cast %6 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x6x1xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


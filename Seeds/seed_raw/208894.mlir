module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-197> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %1 = "tosa.const"() <{values = dense<118> : tensor<1x1xi64>}> : () -> tensor<1x1xi64>
    %2 = "tosa.const"() <{values = dense<1.312500e+02> : tensor<9x4x5xf32>}> : () -> tensor<9x4x5xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<2x8xi64>, tensor<1x1xi64>) -> tensor<2x8xi64>
    %4 = tosa.bitwise_and %3, %3 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    %5 = tosa.ceil %2 : (tensor<9x4x5xf32>) -> tensor<9x4x5xf32>
    %cast = tensor.cast %4 : tensor<2x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<9x4x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


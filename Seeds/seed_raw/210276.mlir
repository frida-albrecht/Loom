module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.562000e+02> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %1 = "tosa.const"() <{values = dense<91.1999969> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = "tosa.const"() <{values = dense<-200> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %3 = "tosa.const"() <{values = dense<-142> : tensor<2x8xi64>}> : () -> tensor<2x8xi64>
    %4 = tosa.pow %0, %1 : (tensor<6x8xf32>, tensor<1x1xf32>) -> tensor<6x8xf32>
    %5 = tosa.pow %4, %4 : (tensor<6x8xf32>, tensor<6x8xf32>) -> tensor<6x8xf32>
    %6 = tosa.rsqrt %5 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %7 = tosa.abs %6 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %8 = tosa.logical_left_shift %2, %3 : (tensor<2x8xi64>, tensor<2x8xi64>) -> tensor<2x8xi64>
    %cast = tensor.cast %7 : tensor<6x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x8xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


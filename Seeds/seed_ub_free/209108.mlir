module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.760900e+02> : tensor<9x6xf32>}> : () -> tensor<9x6xf32>
    %1 = "tosa.const"() <{values = dense<2.002000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = "tosa.const"() <{values = dense<-12> : tensor<7x3xi64>}> : () -> tensor<7x3xi64>
    %c0 = "tosa.const"() <{values = dense<2.002000e+01> : tensor<9x6xf32>}> : () -> tensor<9x6xf32>
    %f0 = tosa.minimum %0, %c0 : (tensor<9x6xf32>, tensor<9x6xf32>) -> tensor<9x6xf32>
    %4 = tosa.clz %2 : (tensor<7x3xi64>) -> tensor<7x3xi64>
    %5 = tosa.pow %f0, %f0 : (tensor<9x6xf32>, tensor<9x6xf32>) -> tensor<9x6xf32>
    %6 = tosa.clamp %4 {max_val = -56 : i64, min_val = -61 : i64} : (tensor<7x3xi64>) -> tensor<7x3xi64>
    %7 = tosa.tanh %5 : (tensor<9x6xf32>) -> tensor<9x6xf32>
    %8 = tosa.reduce_max %7 {axis = 1 : i32} : (tensor<9x6xf32>) -> tensor<9x1xf32>
    %9 = tosa.exp %8 : (tensor<9x1xf32>) -> tensor<9x1xf32>
    %10 = tosa.abs %9 : (tensor<9x1xf32>) -> tensor<9x1xf32>
    %11 = tosa.bitwise_and %6, %6 : (tensor<7x3xi64>, tensor<7x3xi64>) -> tensor<7x3xi64>
    %12 = tosa.floor %10 : (tensor<9x1xf32>) -> tensor<9x1xf32>
    %cast = tensor.cast %11 : tensor<7x3xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %12 : tensor<9x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
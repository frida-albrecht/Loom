module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<8x9x7xi64>}> : () -> tensor<8x9x7xi64>
    %1 = "tosa.const"() <{values = dense<5.306000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<8x9x7xi64>) -> tensor<1x9x7xi64>
    %3 = tosa.identity %2 : (tensor<1x9x7xi64>) -> tensor<1x9x7xi64>
    %4 = tosa.reduce_min %3 {axis = 1 : i32} : (tensor<1x9x7xi64>) -> tensor<1x1x7xi64>
    %5 = tosa.exp %1 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_min %4 {axis = 1 : i32} : (tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %7 = tosa.logical_right_shift %6, %6 : (tensor<1x1x7xi64>, tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %8 = tosa.bitwise_not %7 : (tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %9 = tosa.bitwise_and %8, %6 : (tensor<1x1x7xi64>, tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %10 = tosa.reverse %9 {axis = 2 : i32} : (tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %11 = tosa.add %10, %4 : (tensor<1x1x7xi64>, tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %12 = tosa.abs %11 : (tensor<1x1x7xi64>) -> tensor<1x1x7xi64>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<1x1x7xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


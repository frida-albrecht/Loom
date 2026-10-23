module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.091000e+01> : tensor<7x10xf32>}> : () -> tensor<7x10xf32>
    %1 = "tosa.const"() <{values = dense<143> : tensor<1x7xi64>}> : () -> tensor<1x7xi64>
    %2 = "tosa.const"() <{values = dense<75> : tensor<1x7xi64>}> : () -> tensor<1x7xi64>
    %3 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<7x10xf32>) -> tensor<7x1xf32>
    %4 = tosa.arithmetic_right_shift %1, %2 {round = false} : (tensor<1x7xi64>, tensor<1x7xi64>) -> tensor<1x7xi64>
    %cast = tensor.cast %3 : tensor<7x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<1x7xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


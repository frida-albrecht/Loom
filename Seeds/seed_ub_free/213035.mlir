module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<1x8xi64>}> : () -> tensor<1x8xi64>
    %1 = "tosa.const"() <{values = dense<2.302000e+01> : tensor<7x7xf32>}> : () -> tensor<7x7xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<1x8xi64>) -> tensor<1x8xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.negate %2, %3, %4 : (tensor<1x8xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1x8xi64>
    %6 = tosa.bitwise_or %5, %2 : (tensor<1x8xi64>, tensor<1x8xi64>) -> tensor<1x8xi64>
    %7 = tosa.rsqrt %1 : (tensor<7x7xf32>) -> tensor<7x7xf32>
    %cast = tensor.cast %6 : tensor<1x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<7x7xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


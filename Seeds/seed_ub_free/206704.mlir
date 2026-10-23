module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.993900e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = "tosa.const"() <{values = dense<54> : tensor<7xi64>}> : () -> tensor<7xi64>
    %2 = "tosa.const"() <{values = dense<-80> : tensor<7xi64>}> : () -> tensor<7xi64>
    %3 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<1xf32>
    %4 = tosa.reciprocal %3 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.bitwise_xor %1, %2 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %6 = tosa.bitwise_not %5 : (tensor<7xi64>) -> tensor<7xi64>
    %7 = tosa.clamp %6 {max_val = -31 : i64, min_val = -31 : i64} : (tensor<7xi64>) -> tensor<7xi64>
    %8 = tosa.bitwise_and %5, %7 : (tensor<7xi64>, tensor<7xi64>) -> tensor<7xi64>
    %cast = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<7xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


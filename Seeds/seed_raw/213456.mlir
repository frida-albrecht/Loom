module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-125> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<-130> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-9.096000e+01> : tensor<7x1x5x9xf32>}> : () -> tensor<7x1x5x9xf32>
    %3 = tosa.sub %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.exp %2 : (tensor<7x1x5x9xf32>) -> tensor<7x1x5x9xf32>
    %5 = tosa.log %4 : (tensor<7x1x5x9xf32>) -> tensor<7x1x5x9xf32>
    %6 = tosa.bitwise_or %3, %3 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %5 : tensor<7x1x5x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<i64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


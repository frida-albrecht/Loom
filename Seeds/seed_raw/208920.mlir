module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-178> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %1 = "tosa.const"() <{values = dense<-72> : tensor<10x1x8xi64>}> : () -> tensor<10x1x8xi64>
    %2 = "tosa.const"() <{values = dense<-3.132000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %3 = tosa.minimum %0, %1 : (tensor<10x5x8xi64>, tensor<10x1x8xi64>) -> tensor<10x5x8xi64>
    %4 = tosa.rsqrt %2 : (tensor<4xf32>) -> tensor<4xf32>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<1xf32>
    %6 = tosa.bitwise_and %3, %3 : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %7 = tosa.concat %5, %5 {axis = 0 : i32} : (tensor<1xf32>, tensor<1xf32>) -> tensor<2xf32>
    %8 = tosa.pow %7, %7 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %9 = tosa.floor %8 : (tensor<2xf32>) -> tensor<2xf32>
    %10 = tosa.rsqrt %9 : (tensor<2xf32>) -> tensor<2xf32>
    %11 = tosa.logical_left_shift %3, %3 : (tensor<10x5x8xi64>, tensor<10x5x8xi64>) -> tensor<10x5x8xi64>
    %cast = tensor.cast %6 : tensor<10x5x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %10 : tensor<2xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<10x5x8xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}


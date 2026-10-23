module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<10x6x3xi64>}> : () -> tensor<10x6x3xi64>
    %1 = "tosa.const"() <{values = dense<166> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<179> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<-1.997100e+02> : tensor<2x5x7x1xf32>}> : () -> tensor<2x5x7x1xf32>
    %4 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<10x6x3xi64>) -> tensor<10x6x1xi64>
    %5 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.logical_left_shift %5, %5 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.floor %3 : (tensor<2x5x7x1xf32>) -> tensor<2x5x7x1xf32>
    %8 = tosa.exp %7 : (tensor<2x5x7x1xf32>) -> tensor<2x5x7x1xf32>
    %cast = tensor.cast %4 : tensor<10x6x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_1 = tensor.cast %8 : tensor<2x5x7x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


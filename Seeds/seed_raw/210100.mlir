module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.936000e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<5> : tensor<i64>}> : () -> tensor<i64>
    %2 = tosa.floor %0 : (tensor<2xf32>) -> tensor<2xf32>
    %3 = tosa.reduce_product %2 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<1xf32>
    %4 = tosa.bitwise_not %1 : (tensor<i64>) -> tensor<i64>
    %5 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.bitwise_not %4 : (tensor<i64>) -> tensor<i64>
    %7 = tosa.clamp %4 {max_val = 102 : i64, min_val = 62 : i64} : (tensor<i64>) -> tensor<i64>
    %8 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.tile %2, %8 : (tensor<2xf32>, !tosa.shape<1>) -> tensor<4xf32>
    %10 = tosa.floor %5 : (tensor<1xf32>) -> tensor<1xf32>
    %11 = tosa.clz %6 : (tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %7 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %9 : tensor<4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<1xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %11 : tensor<i64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_2) : (tensor<*xi64>) -> ()
    return
  }
}


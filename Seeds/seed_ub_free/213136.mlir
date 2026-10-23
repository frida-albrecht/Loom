module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<61> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<88> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-1.721200e+02> : tensor<8x3x4x8xf32>}> : () -> tensor<8x3x4x8xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.sigmoid %2 : (tensor<8x3x4x8xf32>) -> tensor<8x3x4x8xf32>
    %5 = tosa.identity %4 : (tensor<8x3x4x8xf32>) -> tensor<8x3x4x8xf32>
    %6 = tosa.concat %5, %4 {axis = 2 : i32} : (tensor<8x3x4x8xf32>, tensor<8x3x4x8xf32>) -> tensor<8x3x8x8xf32>
    %7 = tosa.bitwise_not %3 : (tensor<i64>) -> tensor<i64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i64>}> : () -> tensor<i64>
    %s0 = tosa.maximum %7, %c0 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<i64>}> : () -> tensor<i64>
    %s1 = tosa.minimum %s0, %c63 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %8 = tosa.logical_left_shift %7, %s1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %cast = tensor.cast %6 : tensor<8x3x8x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<i64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}
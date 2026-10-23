module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.068400e+02> : tensor<6x3x5xf32>}> : () -> tensor<6x3x5xf32>
    %1 = "tosa.const"() <{values = dense<4.065000e+01> : tensor<6x3x1xf32>}> : () -> tensor<6x3x1xf32>
    %2 = "tosa.const"() <{values = dense<-129> : tensor<i64>}> : () -> tensor<i64>
    %3 = "tosa.const"() <{values = dense<29> : tensor<i64>}> : () -> tensor<i64>
    %a0 = "tosa.const"() <{values = dense<4.065000e+01> : tensor<6x3x5xf32>}> : () -> tensor<6x3x5xf32>
    %4 = tosa.minimum %0, %a0 : (tensor<6x3x5xf32>, tensor<6x3x5xf32>) -> tensor<6x3x5xf32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<6x3x5xf32>) -> tensor<6x1x5xf32>
    %6 = tosa.logical_right_shift %2, %3 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %7 = tosa.sigmoid %5 : (tensor<6x1x5xf32>) -> tensor<6x1x5xf32>
    %cast = tensor.cast %6 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<6x1x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-56> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %1 = "tosa.const"() <{values = dense<1.153000e+01> : tensor<6x1x1x1xf32>}> : () -> tensor<6x1x1x1xf32>
    %2 = tosa.clz %0 : (tensor<1x2xi64>) -> tensor<1x2xi64>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<1x2xi64>, tensor<1x2xi64>) -> tensor<1x2xi64>
    %4 = tosa.logical_right_shift %3, %2 : (tensor<1x2xi64>, tensor<1x2xi64>) -> tensor<1x2xi64>
    %5 = tosa.const_shape  {values = dense<[2, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %4, %5 : (tensor<1x2xi64>, !tosa.shape<4>) -> tensor<2x1x1x1xi64>
    %7 = tosa.reduce_product %6 {axis = 1 : i32} : (tensor<2x1x1x1xi64>) -> tensor<2x1x1x1xi64>
    %8 = tosa.bitwise_or %7, %7 : (tensor<2x1x1x1xi64>, tensor<2x1x1x1xi64>) -> tensor<2x1x1x1xi64>
    %9 = tosa.ceil %1 : (tensor<6x1x1x1xf32>) -> tensor<6x1x1x1xf32>
    %10 = tosa.clamp %8 {max_val = 18 : i64, min_val = -7 : i64} : (tensor<2x1x1x1xi64>) -> tensor<2x1x1x1xi64>
    %11 = tosa.minimum %10, %7 : (tensor<2x1x1x1xi64>, tensor<2x1x1x1xi64>) -> tensor<2x1x1x1xi64>
    %12 = tosa.rsqrt %9 : (tensor<6x1x1x1xf32>) -> tensor<6x1x1x1xf32>
    %13 = tosa.rsqrt %12 : (tensor<6x1x1x1xf32>) -> tensor<6x1x1x1xf32>
    %14 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %15 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %16 = tosa.negate %9, %14, %15 : (tensor<6x1x1x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<6x1x1x1xf32>
    %17 = tosa.minimum %16, %12 : (tensor<6x1x1x1xf32>, tensor<6x1x1x1xf32>) -> tensor<6x1x1x1xf32>
    %cast = tensor.cast %11 : tensor<2x1x1x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %13 : tensor<6x1x1x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %17 : tensor<6x1x1x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


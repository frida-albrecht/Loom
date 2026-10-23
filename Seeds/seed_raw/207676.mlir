module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-109> : tensor<8x2x8x4xi64>}> : () -> tensor<8x2x8x4xi64>
    %1 = "tosa.const"() <{values = dense<57> : tensor<1x2x8x1xi64>}> : () -> tensor<1x2x8x1xi64>
    %2 = "tosa.const"() <{values = dense<-2.250000e+00> : tensor<10x5xf32>}> : () -> tensor<10x5xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<8x2x8x4xi64>, tensor<1x2x8x1xi64>) -> tensor<8x2x8x4xi64>
    %4 = tosa.sub %3, %3 : (tensor<8x2x8x4xi64>, tensor<8x2x8x4xi64>) -> tensor<8x2x8x4xi64>
    %5 = tosa.sigmoid %2 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %6 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<10x5xf32>) -> tensor<1x5xf32>
    %7 = tosa.exp %6 : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %8 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %9 = tosa.reciprocal %8 : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %10 = tosa.exp %9 : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %11 = tosa.clamp %10 {max_val = -1.300000e+01 : f32, min_val = -2.100000e+01 : f32} : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %12 = tosa.reduce_sum %7 {axis = 1 : i32} : (tensor<1x5xf32>) -> tensor<1x1xf32>
    %13 = tosa.sub %11, %6 : (tensor<1x5xf32>, tensor<1x5xf32>) -> tensor<1x5xf32>
    %cast = tensor.cast %4 : tensor<8x2x8x4xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %12 : tensor<1x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %13 : tensor<1x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


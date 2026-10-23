module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-130> : tensor<7x6x8xi64>}> : () -> tensor<7x6x8xi64>
    %1 = "tosa.const"() <{values = dense<-1.370000e+00> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = tosa.bitwise_not %0 : (tensor<7x6x8xi64>) -> tensor<7x6x8xi64>
    %3 = tosa.log %1 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.sub %3, %3 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %5 = tosa.identity %2 : (tensor<7x6x8xi64>) -> tensor<7x6x8xi64>
    %6 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.tile %4, %6 : (tensor<3xf32>, !tosa.shape<1>) -> tensor<6xf32>
    %8 = tosa.clamp %7 {max_val = -1.600000e+01 : f32, min_val = -1.600000e+01 : f32} : (tensor<6xf32>) -> tensor<6xf32>
    %9 = tosa.maximum %8, %7 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %10 = tosa.sigmoid %9 : (tensor<6xf32>) -> tensor<6xf32>
    %11 = tosa.rsqrt %9 : (tensor<6xf32>) -> tensor<6xf32>
    %12 = tosa.concat %10, %11 {axis = 0 : i32} : (tensor<6xf32>, tensor<6xf32>) -> tensor<12xf32>
    %13 = tosa.add %11, %8 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %5 : tensor<7x6x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %12 : tensor<12xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %13 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


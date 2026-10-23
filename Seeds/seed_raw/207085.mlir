module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<38> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = "tosa.const"() <{values = dense<24> : tensor<3xi32>}> : () -> tensor<3xi32>
    %2 = "tosa.const"() <{values = dense<5.245000e+01> : tensor<10x5x6xf32>}> : () -> tensor<10x5x6xf32>
    %3 = tosa.add %0, %1 : (tensor<3xi32>, tensor<3xi32>) -> tensor<3xi32>
    %4 = tosa.clamp %3 {max_val = 21 : i32, min_val = -11 : i32} : (tensor<3xi32>) -> tensor<3xi32>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<3xi32>) -> tensor<1xi32>
    %6 = tosa.reciprocal %2 : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %7 = tosa.reciprocal %6 : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %8 = tosa.reduce_max %7 {axis = 2 : i32} : (tensor<10x5x6xf32>) -> tensor<10x5x1xf32>
    %9 = tosa.rsqrt %6 : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %10 = tosa.maximum %9, %9 : (tensor<10x5x6xf32>, tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %11 = tosa.reverse %10 {axis = 0 : i32} : (tensor<10x5x6xf32>) -> tensor<10x5x6xf32>
    %12 = tosa.reduce_min %8 {axis = 1 : i32} : (tensor<10x5x1xf32>) -> tensor<10x1x1xf32>
    %13 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %14 = tosa.tile %12, %13 : (tensor<10x1x1xf32>, !tosa.shape<3>) -> tensor<10x1x1xf32>
    %15 = tosa.clz %3 : (tensor<3xi32>) -> tensor<3xi32>
    %cast = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %11 : tensor<10x5x6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %14 : tensor<10x1x1xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %15 : tensor<3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}


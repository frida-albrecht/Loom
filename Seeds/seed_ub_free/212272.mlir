module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<4x9xi32>}> : () -> tensor<4x9xi32>
    %1 = "tosa.const"() <{values = dense<50> : tensor<1x9xi32>}> : () -> tensor<1x9xi32>
    %2 = "tosa.const"() <{values = dense<5.603000e+01> : tensor<5x6x1xf32>}> : () -> tensor<5x6x1xf32>
    %s0 = "tosa.const"() <{values = dense<0> : tensor<1x9xi32>}> : () -> tensor<1x9xi32>
    %s1 = "tosa.const"() <{values = dense<31> : tensor<1x9xi32>}> : () -> tensor<1x9xi32>
    %s2 = tosa.maximum %1, %s0 : (tensor<1x9xi32>, tensor<1x9xi32>) -> tensor<1x9xi32>
    %s3 = tosa.minimum %s2, %s1 : (tensor<1x9xi32>, tensor<1x9xi32>) -> tensor<1x9xi32>
    %3 = tosa.logical_left_shift %0, %s3 : (tensor<4x9xi32>, tensor<1x9xi32>) -> tensor<4x9xi32>
    %4 = tosa.rsqrt %2 : (tensor<5x6x1xf32>) -> tensor<5x6x1xf32>
    %s4 = "tosa.const"() <{values = dense<0> : tensor<4x9xi32>}> : () -> tensor<4x9xi32>
    %s5 = "tosa.const"() <{values = dense<31> : tensor<4x9xi32>}> : () -> tensor<4x9xi32>
    %s6 = tosa.maximum %3, %s4 : (tensor<4x9xi32>, tensor<4x9xi32>) -> tensor<4x9xi32>
    %s7 = tosa.minimum %s6, %s5 : (tensor<4x9xi32>, tensor<4x9xi32>) -> tensor<4x9xi32>
    %5 = tosa.arithmetic_right_shift %3, %s7 {round = false} : (tensor<4x9xi32>, tensor<4x9xi32>) -> tensor<4x9xi32>
    %6 = tosa.rsqrt %4 : (tensor<5x6x1xf32>) -> tensor<5x6x1xf32>
    %7 = tosa.arithmetic_right_shift %5, %s7 {round = false} : (tensor<4x9xi32>, tensor<4x9xi32>) -> tensor<4x9xi32>
    %8 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<5x6x1xf32>) -> tensor<1x6x1xf32>
    %9 = tosa.const_shape  {values = dense<[2, 2, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %10 = tosa.tile %6, %9 : (tensor<5x6x1xf32>, !tosa.shape<3>) -> tensor<10x12x3xf32>
    %11 = tosa.ceil %10 : (tensor<10x12x3xf32>) -> tensor<10x12x3xf32>
    %12 = tosa.bitwise_not %5 : (tensor<4x9xi32>) -> tensor<4x9xi32>
    %13 = tosa.minimum %11, %10 : (tensor<10x12x3xf32>, tensor<10x12x3xf32>) -> tensor<10x12x3xf32>
    %cast = tensor.cast %7 : tensor<4x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<1x6x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<4x9xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %13 : tensor<10x12x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}
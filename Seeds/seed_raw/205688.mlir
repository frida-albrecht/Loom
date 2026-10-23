module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<6x5x2x2xi8>}> : () -> tensor<6x5x2x2xi8>
    %1 = "tosa.const"() <{values = dense<11> : tensor<6x5x24x2xi8>}> : () -> tensor<6x5x24x2xi8>
    %2 = "tosa.const"() <{values = dense<-1.609500e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<false> : tensor<4x8x4xi1>}> : () -> tensor<4x8x4xi1>
    %4 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<6x5x2x2xi8>, tensor<6x5x24x2xi8>) -> tensor<6x5x26x2xi8>
    %5 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.bitwise_not %4 : (tensor<6x5x26x2xi8>) -> tensor<6x5x26x2xi8>
    %7 = tosa.concat %6, %6 {axis = 2 : i32} : (tensor<6x5x26x2xi8>, tensor<6x5x26x2xi8>) -> tensor<6x5x52x2xi8>
    %8 = tosa.reduce_all %3 {axis = 2 : i32} : (tensor<4x8x4xi1>) -> tensor<4x8x1xi1>
    %9 = tosa.reduce_sum %7 {axis = 0 : i32} : (tensor<6x5x52x2xi8>) -> tensor<1x5x52x2xi8>
    %10 = tosa.reduce_product %9 {axis = 1 : i32} : (tensor<1x5x52x2xi8>) -> tensor<1x1x52x2xi8>
    %11 = tosa.const_shape  {values = dense<[3, 2, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %12 = tosa.tile %10, %11 : (tensor<1x1x52x2xi8>, !tosa.shape<4>) -> tensor<3x2x104x4xi8>
    %13 = tosa.const_shape  {values = dense<[2, 3, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %14 = tosa.tile %8, %13 : (tensor<4x8x1xi1>, !tosa.shape<3>) -> tensor<8x24x3xi1>
    %15 = tosa.argmax %14 {axis = 0 : i32} : (tensor<8x24x3xi1>) -> tensor<24x3xi32>
    %16 = tosa.argmax %12 {axis = 1 : i32} : (tensor<3x2x104x4xi8>) -> tensor<3x104x4xi32>
    %17 = tosa.clz %15 : (tensor<24x3xi32>) -> tensor<24x3xi32>
    %18 = tosa.clz %17 : (tensor<24x3xi32>) -> tensor<24x3xi32>
    %19 = tosa.clamp %18 {max_val = 116 : i32, min_val = 43 : i32} : (tensor<24x3xi32>) -> tensor<24x3xi32>
    %20 = tosa.concat %16, %16 {axis = 1 : i32} : (tensor<3x104x4xi32>, tensor<3x104x4xi32>) -> tensor<3x208x4xi32>
    %21 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %22 = tosa.tile %18, %21 : (tensor<24x3xi32>, !tosa.shape<2>) -> tensor<24x6xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %19 : tensor<24x3xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %20 : tensor<3x208x4xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %22 : tensor<24x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}


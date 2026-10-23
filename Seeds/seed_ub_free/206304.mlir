module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<12> : tensor<6xi8>}> : () -> tensor<6xi8>
    %1 = "tosa.const"() <{values = dense<-39> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = "tosa.const"() <{values = dense<1.577200e+02> : tensor<2x1x8x1xf32>}> : () -> tensor<2x1x8x1xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.pad %0, %3, %4 : (tensor<6xi8>, !tosa.shape<2>, tensor<1xi8>) -> tensor<6xi8>
    %6 = tosa.exp %2 : (tensor<2x1x8x1xf32>) -> tensor<2x1x8x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6xi8>}> : () -> tensor<6xi8>
    %clamped_lower = tosa.maximum %5, %c0 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<6xi8>}> : () -> tensor<6xi8>
    %clamped_shift = tosa.minimum %clamped_lower, %c7 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %7 = tosa.logical_left_shift %5, %clamped_shift : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %8 = tosa.clamp %7 {max_val = 127 : i8, min_val = 49 : i8} : (tensor<6xi8>) -> tensor<6xi8>
    %9 = tosa.exp %6 : (tensor<2x1x8x1xf32>) -> tensor<2x1x8x1xf32>
    %10 = tosa.bitwise_not %8 : (tensor<6xi8>) -> tensor<6xi8>
    %11 = tosa.reduce_max %9 {axis = 2 : i32} : (tensor<2x1x8x1xf32>) -> tensor<2x1x1x1xf32>
    %12 = tosa.concat %6, %9 {axis = 0 : i32} : (tensor<2x1x8x1xf32>, tensor<2x1x8x1xf32>) -> tensor<4x1x8x1xf32>
    %13 = tosa.reduce_sum %12 {axis = 0 : i32} : (tensor<4x1x8x1xf32>) -> tensor<1x1x8x1xf32>
    %cast = tensor.cast %10 : tensor<6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %11 : tensor<2x1x1x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %13 : tensor<1x1x8x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}
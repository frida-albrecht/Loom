module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<182> : tensor<4x4x6xi32>}> : () -> tensor<4x4x6xi32>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<4x4x6xi32>) -> tensor<1x4x6xi32>
    %2 = tosa.minimum %1, %1 : (tensor<1x4x6xi32>, tensor<1x4x6xi32>) -> tensor<1x4x6xi32>
    %3 = tosa.reduce_product %2 {axis = 1 : i32} : (tensor<1x4x6xi32>) -> tensor<1x1x6xi32>
    %4 = tosa.clamp %3 {max_val = 167 : i32, min_val = 58 : i32} : (tensor<1x1x6xi32>) -> tensor<1x1x6xi32>
    %5 = tosa.const_shape  {values = dense<6> : tensor<1xindex>} : () -> !tosa.shape<1>
    %6 = tosa.reshape %4, %5 : (tensor<1x1x6xi32>, !tosa.shape<1>) -> tensor<6xi32>
    %7 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %8 = tosa.tile %6, %7 : (tensor<6xi32>, !tosa.shape<1>) -> tensor<12xi32>
    %cast = tensor.cast %8 : tensor<12xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


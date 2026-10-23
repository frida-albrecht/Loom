module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<187> : tensor<8x9x7x9xi32>}> : () -> tensor<8x9x7x9xi32>
    %1 = tosa.abs %0 : (tensor<8x9x7x9xi32>) -> tensor<8x9x7x9xi32>
    %2 = tosa.reduce_max %1 {axis = 1 : i32} : (tensor<8x9x7x9xi32>) -> tensor<8x1x7x9xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<8x1x7x9xi32>}> : () -> tensor<8x1x7x9xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<8x1x7x9xi32>}> : () -> tensor<8x1x7x9xi32>
    %a0 = tosa.maximum %2, %c0 : (tensor<8x1x7x9xi32>, tensor<8x1x7x9xi32>) -> tensor<8x1x7x9xi32>
    %a1 = tosa.minimum %a0, %c31 : (tensor<8x1x7x9xi32>, tensor<8x1x7x9xi32>) -> tensor<8x1x7x9xi32>
    %3 = tosa.logical_right_shift %2, %a1 : (tensor<8x1x7x9xi32>, tensor<8x1x7x9xi32>) -> tensor<8x1x7x9xi32>
    %4 = tosa.const_shape  {values = dense<[7, 72]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.reshape %3, %4 : (tensor<8x1x7x9xi32>, !tosa.shape<2>) -> tensor<7x72xi32>
    %cast = tensor.cast %5 : tensor<7x72xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}
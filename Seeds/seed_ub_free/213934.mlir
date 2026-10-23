module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<161> : tensor<7x8x2x2xi32>}> : () -> tensor<7x8x2x2xi32>
    %1 = tosa.bitwise_not %0 : (tensor<7x8x2x2xi32>) -> tensor<7x8x2x2xi32>
    %2 = tosa.bitwise_not %1 : (tensor<7x8x2x2xi32>) -> tensor<7x8x2x2xi32>
    %3 = tosa.reduce_max %2 {axis = 3 : i32} : (tensor<7x8x2x2xi32>) -> tensor<7x8x2x1xi32>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<7x8x2x1xi32>, tensor<7x8x2x1xi32>) -> tensor<7x8x2x1xi32>
    %5 = tosa.add %4, %3 : (tensor<7x8x2x1xi32>, tensor<7x8x2x1xi32>) -> tensor<7x8x2x1xi32>
    %6 = tosa.const_shape  {values = dense<[1, 7, 16]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %5, %6 : (tensor<7x8x2x1xi32>, !tosa.shape<3>) -> tensor<1x7x16xi32>
    %cast = tensor.cast %7 : tensor<1x7x16xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


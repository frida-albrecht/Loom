module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-90> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<1.970200e+02> : tensor<6x2x2x1xf32>}> : () -> tensor<6x2x2x1xf32>
    %2 = tosa.bitwise_not %0 : (tensor<8xi32>) -> tensor<8xi32>
    %3 = tosa.bitwise_not %2 : (tensor<8xi32>) -> tensor<8xi32>
    %4 = tosa.log %1 : (tensor<6x2x2x1xf32>) -> tensor<6x2x2x1xf32>
    %5 = tosa.abs %4 : (tensor<6x2x2x1xf32>) -> tensor<6x2x2x1xf32>
    %6 = tosa.add %5, %5 : (tensor<6x2x2x1xf32>, tensor<6x2x2x1xf32>) -> tensor<6x2x2x1xf32>
    %7 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<1xi32>
    %8 = tosa.const_shape  {values = dense<[2, 2, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.tile %6, %8 : (tensor<6x2x2x1xf32>, !tosa.shape<4>) -> tensor<12x4x2x2xf32>
    %cast = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<12x4x2x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


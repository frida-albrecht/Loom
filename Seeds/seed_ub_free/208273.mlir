module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-99> : tensor<9x2x6xi32>}> : () -> tensor<9x2x6xi32>
    %1 = "tosa.const"() <{values = dense<-1.277900e+02> : tensor<2x6x3xf32>}> : () -> tensor<2x6x3xf32>
    %2 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<9x2x6xi32>) -> tensor<9x1x6xi32>
    %3 = tosa.reduce_sum %2 {axis = 1 : i32} : (tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %4 = tosa.bitwise_and %3, %2 : (tensor<9x1x6xi32>, tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %5 = tosa.rsqrt %1 : (tensor<2x6x3xf32>) -> tensor<2x6x3xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x1x6xi32>}> : () -> tensor<9x1x6xi32>
    %c1 = "tosa.const"() <{values = dense<31> : tensor<9x1x6xi32>}> : () -> tensor<9x1x6xi32>
    %t0 = tosa.maximum %2, %c0 : (tensor<9x1x6xi32>, tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %t1 = tosa.minimum %t0, %c1 : (tensor<9x1x6xi32>, tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %6 = tosa.arithmetic_right_shift %4, %t1 {round = true} : (tensor<9x1x6xi32>, tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %7 = tosa.add %6, %4 : (tensor<9x1x6xi32>, tensor<9x1x6xi32>) -> tensor<9x1x6xi32>
    %8 = tosa.const_shape  {values = dense<[1, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %9 = tosa.tile %7, %8 : (tensor<9x1x6xi32>, !tosa.shape<3>) -> tensor<9x3x12xi32>
    %10 = tosa.reduce_min %9 {axis = 0 : i32} : (tensor<9x3x12xi32>) -> tensor<1x3x12xi32>
    %cast = tensor.cast %5 : tensor<2x6x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<1x3x12xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-151> : tensor<2x2x8xi64>}> : () -> tensor<2x2x8xi64>
    %1 = "tosa.const"() <{values = dense<-1.641900e+02> : tensor<3x10x8x6xf32>}> : () -> tensor<3x10x8x6xf32>
    %2 = tosa.abs %0 : (tensor<2x2x8xi64>) -> tensor<2x2x8xi64>
    %3 = tosa.exp %1 : (tensor<3x10x8x6xf32>) -> tensor<3x10x8x6xf32>
    %4 = tosa.concat %3, %3 {axis = 3 : i32} : (tensor<3x10x8x6xf32>, tensor<3x10x8x6xf32>) -> tensor<3x10x8x12xf32>
    %5 = tosa.ceil %4 : (tensor<3x10x8x12xf32>) -> tensor<3x10x8x12xf32>
    %6 = tosa.const_shape  {values = dense<[2, 2, 3, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %7 = tosa.tile %5, %6 : (tensor<3x10x8x12xf32>, !tosa.shape<4>) -> tensor<6x20x24x24xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2x2x8xi64>}> : () -> tensor<2x2x8xi64>
    %c1 = "tosa.const"() <{values = dense<63> : tensor<2x2x8xi64>}> : () -> tensor<2x2x8xi64>
    %t0 = tosa.maximum %2, %c0 : (tensor<2x2x8xi64>, tensor<2x2x8xi64>) -> tensor<2x2x8xi64>
    %t1 = tosa.minimum %t0, %c1 : (tensor<2x2x8xi64>, tensor<2x2x8xi64>) -> tensor<2x2x8xi64>
    %8 = tosa.logical_left_shift %2, %t1 : (tensor<2x2x8xi64>, tensor<2x2x8xi64>) -> tensor<2x2x8xi64>
    %9 = tosa.logical_right_shift %2, %t1 : (tensor<2x2x8xi64>, tensor<2x2x8xi64>) -> tensor<2x2x8xi64>
    %cast = tensor.cast %7 : tensor<6x20x24x24xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x2x8xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %9 : tensor<2x2x8xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}
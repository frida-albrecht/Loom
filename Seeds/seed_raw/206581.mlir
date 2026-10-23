module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-55> : tensor<6x8x1x10xi32>}> : () -> tensor<6x8x1x10xi32>
    %1 = "tosa.const"() <{values = dense<-1.889400e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<[3, 3, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %0, %2 : (tensor<6x8x1x10xi32>, !tosa.shape<4>) -> tensor<18x24x1x20xi32>
    %4 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.ceil %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.exp %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.logical_left_shift %3, %3 : (tensor<18x24x1x20xi32>, tensor<18x24x1x20xi32>) -> tensor<18x24x1x20xi32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %9 = tosa.reshape %6, %8 : (tensor<f32>, !tosa.shape<2>) -> tensor<1x1xf32>
    %10 = tosa.reduce_max %9 {axis = 0 : i32} : (tensor<1x1xf32>) -> tensor<1x1xf32>
    %cast = tensor.cast %7 : tensor<18x24x1x20xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<103> : tensor<10x10x1xi32>}> : () -> tensor<10x10x1xi32>
    %1 = "tosa.const"() <{values = dense<-44> : tensor<10x1x1xi32>}> : () -> tensor<10x1x1xi32>
    %2 = "tosa.const"() <{values = dense<1.367900e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<4.233000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.intdiv %0, %1 : (tensor<10x10x1xi32>, tensor<10x1x1xi32>) -> tensor<10x10x1xi32>
    %5 = tosa.reverse %4 {axis = 2 : i32} : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %6 = tosa.identity %5 : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %7 = tosa.maximum %6, %4 : (tensor<10x10x1xi32>, tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %8 = tosa.sub %7, %7 : (tensor<10x10x1xi32>, tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %9 = tosa.sub %8, %7 : (tensor<10x10x1xi32>, tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %10 = tosa.reduce_min %9 {axis = 2 : i32} : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %11 = tosa.pow %2, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %12 = tosa.clz %10 : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %13 = tosa.reduce_sum %12 {axis = 2 : i32} : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %14 = tosa.const_shape  {values = dense<[2, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %15 = tosa.tile %13, %14 : (tensor<10x10x1xi32>, !tosa.shape<3>) -> tensor<20x20x1xi32>
    %16 = tosa.log %11 : (tensor<f32>) -> tensor<f32>
    %17 = tosa.exp %16 : (tensor<f32>) -> tensor<f32>
    %18 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %19 = tosa.reshape %11, %18 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %20 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %21 = tosa.reshape %19, %20 : (tensor<1x1x1x1xf32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %22 = tosa.clz %10 : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %23 = tosa.reverse %21 {axis = 0 : i32} : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %15 : tensor<20x20x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %17 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %22 : tensor<10x10x1xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %23 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}


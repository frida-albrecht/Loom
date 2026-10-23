module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.557800e+02> : tensor<8x3x5xf32>}> : () -> tensor<8x3x5xf32>
    %1 = "tosa.const"() <{values = dense<-174> : tensor<1x10x9x4xi32>}> : () -> tensor<1x10x9x4xi32>
    %2 = "tosa.const"() <{values = dense<-137> : tensor<1x10x9x4xi32>}> : () -> tensor<1x10x9x4xi32>
    %3 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<8x3x5xf32>) -> tensor<1x3x5xf32>
    %4 = tosa.pow %3, %3 : (tensor<1x3x5xf32>, tensor<1x3x5xf32>) -> tensor<1x3x5xf32>
    %5 = tosa.clamp %4 {max_val = 6.500000e+01 : f32, min_val = 4.000000e+00 : f32} : (tensor<1x3x5xf32>) -> tensor<1x3x5xf32>
    %6 = tosa.const_shape  {values = dense<[5, 3, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %7 = tosa.reshape %5, %6 : (tensor<1x3x5xf32>, !tosa.shape<4>) -> tensor<5x3x1x1xf32>
    %8 = tosa.identity %7 : (tensor<5x3x1x1xf32>) -> tensor<5x3x1x1xf32>
    %9 = tosa.maximum %8, %7 : (tensor<5x3x1x1xf32>, tensor<5x3x1x1xf32>) -> tensor<5x3x1x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x10x9x4xi32>}> : () -> tensor<1x10x9x4xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<1x10x9x4xi32>}> : () -> tensor<1x10x9x4xi32>
    %a0 = tosa.maximum %2, %c0 : (tensor<1x10x9x4xi32>, tensor<1x10x9x4xi32>) -> tensor<1x10x9x4xi32>
    %a1 = tosa.minimum %a0, %c31 : (tensor<1x10x9x4xi32>, tensor<1x10x9x4xi32>) -> tensor<1x10x9x4xi32>
    %10 = tosa.logical_left_shift %1, %a1 : (tensor<1x10x9x4xi32>, tensor<1x10x9x4xi32>) -> tensor<1x10x9x4xi32>
    %cast = tensor.cast %9 : tensor<5x3x1x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<1x10x9x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}
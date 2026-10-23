module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<99> : tensor<9x6x1xi32>}> : () -> tensor<9x6x1xi32>
    %1 = "tosa.const"() <{values = dense<170> : tensor<9x1x1xi32>}> : () -> tensor<9x1x1xi32>
    %2 = "tosa.const"() <{values = dense<1.726800e+02> : tensor<10x2x4x1xf32>}> : () -> tensor<10x2x4x1xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<9x6x1xi32>, tensor<9x1x1xi32>) -> tensor<9x6x1xi32>
    %4 = tosa.concat %3, %3 {axis = 2 : i32} : (tensor<9x6x1xi32>, tensor<9x6x1xi32>) -> tensor<9x6x2xi32>
    %5 = tosa.exp %2 : (tensor<10x2x4x1xf32>) -> tensor<10x2x4x1xf32>
    %6 = tosa.bitwise_not %4 : (tensor<9x6x2xi32>) -> tensor<9x6x2xi32>
    %7 = tosa.clamp %6 {max_val = 80 : i32, min_val = 19 : i32} : (tensor<9x6x2xi32>) -> tensor<9x6x2xi32>
    %8 = tosa.exp %5 : (tensor<10x2x4x1xf32>) -> tensor<10x2x4x1xf32>
    %9 = tosa.pow %8, %8 : (tensor<10x2x4x1xf32>, tensor<10x2x4x1xf32>) -> tensor<10x2x4x1xf32>
    %10 = tosa.const_shape  {values = dense<[2, 40]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %11 = tosa.reshape %5, %10 : (tensor<10x2x4x1xf32>, !tosa.shape<2>) -> tensor<2x40xf32>
    %12 = tosa.reciprocal %9 : (tensor<10x2x4x1xf32>) -> tensor<10x2x4x1xf32>
    %cast = tensor.cast %7 : tensor<9x6x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %11 : tensor<2x40xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<10x2x4x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


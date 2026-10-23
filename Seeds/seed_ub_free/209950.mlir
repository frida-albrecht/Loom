module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.635000e+01> : tensor<4x3x7x4xf32>}> : () -> tensor<4x3x7x4xf32>
    %1 = "tosa.const"() <{values = dense<1.681700e+02> : tensor<4x3x1x4xf32>}> : () -> tensor<4x3x1x4xf32>
    %2 = tosa.pow %0, %1 : (tensor<4x3x7x4xf32>, tensor<4x3x1x4xf32>) -> tensor<4x3x7x4xf32>
    %3 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<4x3x7x4xf32>) -> tensor<1x3x7x4xf32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<1x3x7x4xf32>) -> tensor<1x7x4xi32>
    %5 = tosa.tanh %2 : (tensor<4x3x7x4xf32>) -> tensor<4x3x7x4xf32>
    %6 = tosa.tanh %5 : (tensor<4x3x7x4xf32>) -> tensor<4x3x7x4xf32>
    %7 = tosa.reverse %4 {axis = 0 : i32} : (tensor<1x7x4xi32>) -> tensor<1x7x4xi32>
    %8 = tosa.concat %7, %7 {axis = 2 : i32} : (tensor<1x7x4xi32>, tensor<1x7x4xi32>) -> tensor<1x7x8xi32>
    %9 = tosa.const_shape  {values = dense<[2, 3, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %10 = tosa.tile %8, %9 : (tensor<1x7x8xi32>, !tosa.shape<3>) -> tensor<2x21x24xi32>
    %11 = tosa.floor %2 : (tensor<4x3x7x4xf32>) -> tensor<4x3x7x4xf32>
    %cast = tensor.cast %6 : tensor<4x3x7x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<2x21x24xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %11 : tensor<4x3x7x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


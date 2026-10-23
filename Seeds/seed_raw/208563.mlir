module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84> : tensor<6x9x3x9xi32>}> : () -> tensor<6x9x3x9xi32>
    %1 = "tosa.const"() <{values = dense<1.096300e+02> : tensor<9x7x1xf32>}> : () -> tensor<9x7x1xf32>
    %2 = tosa.const_shape  {values = dense<[1, 3, 1, 486]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %0, %2 : (tensor<6x9x3x9xi32>, !tosa.shape<4>) -> tensor<1x3x1x486xi32>
    %4 = tosa.ceil %1 : (tensor<9x7x1xf32>) -> tensor<9x7x1xf32>
    %5 = tosa.pow %4, %4 : (tensor<9x7x1xf32>, tensor<9x7x1xf32>) -> tensor<9x7x1xf32>
    %6 = "tosa.const"() <{values = dense<[0, 1, 2]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %7 = tosa.transpose %4 {perms = array<i32: 0, 1, 2>} : (tensor<9x7x1xf32>) -> tensor<9x7x1xf32>
    %8 = tosa.rsqrt %7 : (tensor<9x7x1xf32>) -> tensor<9x7x1xf32>
    %cast = tensor.cast %3 : tensor<1x3x1x486xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<9x7x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<9x7x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<4x7x8x7xi32>}> : () -> tensor<4x7x8x7xi32>
    %1 = "tosa.const"() <{values = dense<2.036000e+01> : tensor<9x5xf32>}> : () -> tensor<9x5xf32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<4x7x8x7xi32>) -> tensor<4x8x7xi32>
    %3 = tosa.rsqrt %1 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %4 = tosa.logical_right_shift %2, %2 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %5 = tosa.argmax %4 {axis = 2 : i32} : (tensor<4x8x7xi32>) -> tensor<4x8xi32>
    %6 = tosa.sigmoid %3 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %7 = tosa.intdiv %4, %2 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %8 = tosa.rsqrt %6 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %9 = tosa.bitwise_and %5, %5 : (tensor<4x8xi32>, tensor<4x8xi32>) -> tensor<4x8xi32>
    %10 = tosa.intdiv %7, %4 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %cast = tensor.cast %8 : tensor<9x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<4x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<4x8x7xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}


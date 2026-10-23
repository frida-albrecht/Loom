module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<198> : tensor<2x3x4x8xi32>}> : () -> tensor<2x3x4x8xi32>
    %1 = "tosa.const"() <{values = dense<32> : tensor<1x3x1x1xi32>}> : () -> tensor<1x3x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-1.539000e+02> : tensor<4x9x5x3xf32>}> : () -> tensor<4x9x5x3xf32>
    %3 = tosa.intdiv %0, %1 : (tensor<2x3x4x8xi32>, tensor<1x3x1x1xi32>) -> tensor<2x3x4x8xi32>
    %4 = tosa.floor %2 : (tensor<4x9x5x3xf32>) -> tensor<4x9x5x3xf32>
    %5 = tosa.clz %3 : (tensor<2x3x4x8xi32>) -> tensor<2x3x4x8xi32>
    %6 = tosa.minimum %5, %3 : (tensor<2x3x4x8xi32>, tensor<2x3x4x8xi32>) -> tensor<2x3x4x8xi32>
    %7 = tosa.arithmetic_right_shift %6, %3 {round = true} : (tensor<2x3x4x8xi32>, tensor<2x3x4x8xi32>) -> tensor<2x3x4x8xi32>
    %8 = tosa.exp %4 : (tensor<4x9x5x3xf32>) -> tensor<4x9x5x3xf32>
    %9 = tosa.reciprocal %8 : (tensor<4x9x5x3xf32>) -> tensor<4x9x5x3xf32>
    %10 = "tosa.const"() <{values = dense<[0, 1, 3, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %11 = tosa.transpose %4 {perms = array<i32: 0, 1, 3, 2>} : (tensor<4x9x5x3xf32>) -> tensor<4x9x3x5xf32>
    %12 = tosa.bitwise_and %3, %3 : (tensor<2x3x4x8xi32>, tensor<2x3x4x8xi32>) -> tensor<2x3x4x8xi32>
    %cast = tensor.cast %7 : tensor<2x3x4x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<4x9x5x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<4x9x3x5xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %12 : tensor<2x3x4x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}


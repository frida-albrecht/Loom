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
    // For tosa.intdiv %4, %2, the second operand %2 can contain 0s, leading to division by zero.
    // %2 is a tensor<4x8x7xi32> and, given %0 is all 17s, %2 contains all 0s.
    // Insert ops to clamp %2 to a minimum of 1.
    %c1 = "tosa.const"() <{values = dense<1> : tensor<4x8x7xi32>}> : () -> tensor<4x8x7xi32>
    %s1 = tosa.maximum %2, %c1 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %7 = tosa.intdiv %4, %s1 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %8 = tosa.rsqrt %6 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %9 = tosa.bitwise_and %5, %5 : (tensor<4x8xi32>, tensor<4x8xi32>) -> tensor<4x8xi32>
    // For tosa.intdiv %7, %4, the second operand %4 can contain 0s, leading to division by zero.
    // %4 is a tensor<4x8x7xi32> and contains all 0s.
    // Insert ops to clamp %4 to a minimum of 1. Re-use %c1 constant.
    %s2 = tosa.maximum %4, %c1 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %10 = tosa.intdiv %7, %s2 : (tensor<4x8x7xi32>, tensor<4x8x7xi32>) -> tensor<4x8x7xi32>
    %cast = tensor.cast %8 : tensor<9x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<4x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<4x8x7xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}
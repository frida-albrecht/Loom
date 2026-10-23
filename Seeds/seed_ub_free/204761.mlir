module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<2x6x9x6xi8>}> : () -> tensor<2x6x9x6xi8>
    %1 = "tosa.const"() <{values = dense<-4.192000e+01> : tensor<3x5x10xf32>}> : () -> tensor<3x5x10xf32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<2x6x9x6xi8>) -> tensor<2x6x9x6xi8>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<2x6x9x6xi8>) -> tensor<6x9x6xi32>
    // Undefined Behavior: tosa.intdiv requires the divisor (second operand) to be non-zero.
    // The operand %3 (output of tosa.argmax) can contain 0, leading to division by zero.
    // Fix: Clamp the divisor to a minimum of 1 using tosa.const and tosa.maximum.
    %c1 = "tosa.const"() <{values = dense<1> : tensor<6x9x6xi32>}> : () -> tensor<6x9x6xi32>
    %t1 = tosa.maximum %3, %c1 : (tensor<6x9x6xi32>, tensor<6x9x6xi32>) -> tensor<6x9x6xi32>
    %4 = tosa.intdiv %3, %t1 : (tensor<6x9x6xi32>, tensor<6x9x6xi32>) -> tensor<6x9x6xi32>
    %5 = tosa.rsqrt %1 : (tensor<3x5x10xf32>) -> tensor<3x5x10xf32>
    %6 = tosa.rsqrt %5 : (tensor<3x5x10xf32>) -> tensor<3x5x10xf32>
    %7 = tosa.arithmetic_right_shift %4, %3 {round = false} : (tensor<6x9x6xi32>, tensor<6x9x6xi32>) -> tensor<6x9x6xi32>
    %8 = "tosa.const"() <{values = dense<[1, 2, 0]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %9 = tosa.transpose %5 {perms = array<i32: 1, 2, 0>} : (tensor<3x5x10xf32>) -> tensor<5x10x3xf32>
    %cast = tensor.cast %6 : tensor<3x5x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<6x9x6xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<5x10x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}
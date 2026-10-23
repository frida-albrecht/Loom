module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.261000e+01> : tensor<4x3xf32>}> : () -> tensor<4x3xf32>
    %1 = tosa.tanh %0 : (tensor<4x3xf32>) -> tensor<4x3xf32>
    %2 = tosa.argmax %1 {axis = 1 : i32} : (tensor<4x3xf32>) -> tensor<4xi32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<4xi32>, tensor<4xi32>) -> tensor<8xi32>
    %4 = tosa.logical_left_shift %3, %3 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    // Fix for tosa.intdiv: The second operand (divisor) must not be zero.
    // Clamp the divisor (%4) to a minimum value of 1.
    %c0 = "tosa.const"() <{values = dense<1> : tensor<8xi32>}> : () -> tensor<8xi32>
    %s0 = tosa.maximum %4, %c0 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %5 = tosa.intdiv %4, %s0 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %6 = tosa.identity %5 : (tensor<8xi32>) -> tensor<8xi32>
    %7 = tosa.reverse %6 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<8xi32>
    %8 = tosa.sigmoid %1 : (tensor<4x3xf32>) -> tensor<4x3xf32>
    %9 = tosa.clz %7 : (tensor<8xi32>) -> tensor<8xi32>
    %10 = tosa.arithmetic_right_shift %9, %6 {round = false} : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %11 = tosa.pow %8, %8 : (tensor<4x3xf32>, tensor<4x3xf32>) -> tensor<4x3xf32>
    %12 = tosa.reduce_sum %10 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<1xi32>
    %cast = tensor.cast %11 : tensor<4x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}
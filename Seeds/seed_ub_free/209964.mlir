module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.231000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.394200e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<4> : tensor<3x10x8xi64>}> : () -> tensor<3x10x8xi64>
    %3 = "tosa.const"() <{values = dense<125> : tensor<1x1x8xi64>}> : () -> tensor<1x1x8xi64>
    %4 = tosa.sub %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // Undefined behavior detected for tosa.logical_right_shift:
    // The shift amount (value 125 from %3) for i64 type must be in the range [0, 63].
    // Fixing by clamping the shift amount operand.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x8xi64>}> : () -> tensor<1x1x8xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x1x8xi64>}> : () -> tensor<1x1x8xi64>
    %l1 = tosa.maximum %3, %c0 : (tensor<1x1x8xi64>, tensor<1x1x8xi64>) -> tensor<1x1x8xi64>
    %l2 = tosa.minimum %l1, %c63 : (tensor<1x1x8xi64>, tensor<1x1x8xi64>) -> tensor<1x1x8xi64>
    %5 = tosa.logical_right_shift %2, %l2 : (tensor<3x10x8xi64>, tensor<1x1x8xi64>) -> tensor<3x10x8xi64>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<3x10x8xi64>) -> tensor<10x8xi32>
    %7 = tosa.bitwise_xor %6, %6 : (tensor<10x8xi32>, tensor<10x8xi32>) -> tensor<10x8xi32>
    %8 = tosa.add %7, %7 : (tensor<10x8xi32>, tensor<10x8xi32>) -> tensor<10x8xi32>
    %9 = tosa.identity %5 : (tensor<3x10x8xi64>) -> tensor<3x10x8xi64>
    %10 = tosa.concat %9, %5 {axis = 2 : i32} : (tensor<3x10x8xi64>, tensor<3x10x8xi64>) -> tensor<3x10x16xi64>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<10x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<3x10x16xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}
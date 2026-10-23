module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.249000e+02> : tensor<4x3x7xf32>}> : () -> tensor<4x3x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.677400e+02> : tensor<4x1x7xf32>}> : () -> tensor<4x1x7xf32>
    %2 = "tosa.const"() <{values = dense<-61> : tensor<8x6x3xi64>}> : () -> tensor<8x6x3xi64>
    %3 = "tosa.const"() <{values = dense<153> : tensor<1x1x1xi64>}> : () -> tensor<1x1x1xi64>
    %4 = tosa.add %0, %1 : (tensor<4x3x7xf32>, tensor<4x1x7xf32>) -> tensor<4x3x7xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1xi64>}> : () -> tensor<1x1x1xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<1x1x1xi64>}> : () -> tensor<1x1x1xi64>
    %clamped_shift_lower = tosa.maximum %3, %c0 : (tensor<1x1x1xi64>, tensor<1x1x1xi64>) -> tensor<1x1x1xi64>
    %clamped_shift = tosa.minimum %clamped_shift_lower, %c63 : (tensor<1x1x1xi64>, tensor<1x1x1xi64>) -> tensor<1x1x1xi64>
    %5 = tosa.logical_right_shift %2, %clamped_shift : (tensor<8x6x3xi64>, tensor<1x1x1xi64>) -> tensor<8x6x3xi64>
    %6 = tosa.argmax %5 {axis = 1 : i32} : (tensor<8x6x3xi64>) -> tensor<8x3xi32>
    %7 = tosa.bitwise_xor %6, %6 : (tensor<8x3xi32>, tensor<8x3xi32>) -> tensor<8x3xi32>
    %8 = tosa.bitwise_xor %6, %7 : (tensor<8x3xi32>, tensor<8x3xi32>) -> tensor<8x3xi32>
    %cast = tensor.cast %4 : tensor<4x3x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<8x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}
module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<182> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %1 = "tosa.const"() <{values = dense<-180> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = "tosa.const"() <{values = dense<-1.479300e+02> : tensor<9x8x8x5xf32>}> : () -> tensor<9x8x8x5xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<4x2xi64>, tensor<1x2xi64>) -> tensor<4x2xi64>
    %4 = tosa.log %2 : (tensor<9x8x8x5xf32>) -> tensor<9x8x8x5xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %l0 = tosa.maximum %3, %c0 : (tensor<4x2xi64>, tensor<4x2xi64>) -> tensor<4x2xi64>
    %l1 = tosa.minimum %l0, %c63 : (tensor<4x2xi64>, tensor<4x2xi64>) -> tensor<4x2xi64>
    %5 = tosa.logical_right_shift %3, %l1 : (tensor<4x2xi64>, tensor<4x2xi64>) -> tensor<4x2xi64>
    %6 = tosa.sigmoid %4 : (tensor<9x8x8x5xf32>) -> tensor<9x8x8x5xf32>
    %7 = tosa.clamp %4 {max_val = 7.700000e+01 : f32, min_val = 2.100000e+01 : f32} : (tensor<9x8x8x5xf32>) -> tensor<9x8x8x5xf32>
    %8 = tosa.sub %6, %6 : (tensor<9x8x8x5xf32>, tensor<9x8x8x5xf32>) -> tensor<9x8x8x5xf32>
    %9 = tosa.sub %8, %4 : (tensor<9x8x8x5xf32>, tensor<9x8x8x5xf32>) -> tensor<9x8x8x5xf32>
    %cast = tensor.cast %5 : tensor<4x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<9x8x8x5xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<9x8x8x5xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}
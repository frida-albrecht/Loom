module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<1x10x4xi64>}> : () -> tensor<1x10x4xi64>
    %1 = "tosa.const"() <{values = dense<7.352000e+01> : tensor<8x7x5x10xf32>}> : () -> tensor<8x7x5x10xf32>
    %2 = tosa.const_shape  {values = dense<[2, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.tile %0, %2 : (tensor<1x10x4xi64>, !tosa.shape<3>) -> tensor<2x30x4xi64>
    %4 = tosa.floor %1 : (tensor<8x7x5x10xf32>) -> tensor<8x7x5x10xf32>
    %5 = tosa.clz %3 : (tensor<2x30x4xi64>) -> tensor<2x30x4xi64>
    %6 = tosa.tanh %4 : (tensor<8x7x5x10xf32>) -> tensor<8x7x5x10xf32>
    %7 = tosa.ceil %6 : (tensor<8x7x5x10xf32>) -> tensor<8x7x5x10xf32>
    %s0 = "tosa.const"() <{values = dense<0> : tensor<2x30x4xi64>}> : () -> tensor<2x30x4xi64>
    %s1 = "tosa.const"() <{values = dense<63> : tensor<2x30x4xi64>}> : () -> tensor<2x30x4xi64>
    %t0 = tosa.maximum %3, %s0 : (tensor<2x30x4xi64>, tensor<2x30x4xi64>) -> tensor<2x30x4xi64>
    %t1 = tosa.minimum %t0, %s1 : (tensor<2x30x4xi64>, tensor<2x30x4xi64>) -> tensor<2x30x4xi64>
    %8 = tosa.logical_right_shift %3, %t1 : (tensor<2x30x4xi64>, tensor<2x30x4xi64>) -> tensor<2x30x4xi64>
    %cast = tensor.cast %5 : tensor<2x30x4xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<8x7x5x10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<2x30x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}
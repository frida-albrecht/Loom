module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<24> : tensor<8x8x8x8xi64>}> : () -> tensor<8x8x8x8xi64>
    %1 = "tosa.const"() <{values = dense<-36> : tensor<8x41x8x8xi64>}> : () -> tensor<8x41x8x8xi64>
    %2 = "tosa.const"() <{values = dense<7.160000e+00> : tensor<3x3xf32>}> : () -> tensor<3x3xf32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<8x8x8x8xi64>, tensor<8x41x8x8xi64>) -> tensor<8x49x8x8xi64>
    %4 = tosa.abs %3 : (tensor<8x49x8x8xi64>) -> tensor<8x49x8x8xi64>
    %5 = tosa.const_shape  {values = dense<[896, 14, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %4, %5 : (tensor<8x49x8x8xi64>, !tosa.shape<3>) -> tensor<896x14x2xi64>
    %7 = tosa.log %2 : (tensor<3x3xf32>) -> tensor<3x3xf32>
    %8 = tosa.const_shape  {values = dense<25088> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.reshape %6, %8 : (tensor<896x14x2xi64>, !tosa.shape<1>) -> tensor<25088xi64>
    %cast = tensor.cast %7 : tensor<3x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<25088xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


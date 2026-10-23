module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-110> : tensor<4x5x2x8xi64>}> : () -> tensor<4x5x2x8xi64>
    %1 = "tosa.const"() <{values = dense<-1.718000e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<4x5x2x8xi64>) -> tensor<4x1x2x8xi64>
    %3 = tosa.bitwise_and %2, %2 : (tensor<4x1x2x8xi64>, tensor<4x1x2x8xi64>) -> tensor<4x1x2x8xi64>
    %4 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.const_shape  {values = dense<[4, 16, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %3, %5 : (tensor<4x1x2x8xi64>, !tosa.shape<3>) -> tensor<4x16x1xi64>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<4x16x1xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.155000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<127> : tensor<3x5x7x5xi64>}> : () -> tensor<3x5x7x5xi64>
    %2 = tosa.rsqrt %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.const_shape  {values = dense<[1, 1, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %1, %3 : (tensor<3x5x7x5xi64>, !tosa.shape<4>) -> tensor<3x5x14x10xi64>
    %5 = tosa.bitwise_not %4 : (tensor<3x5x14x10xi64>) -> tensor<3x5x14x10xi64>
    %6 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<3x5x14x10xi64>) -> tensor<1x5x14x10xi64>
    %7 = tosa.floor %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %6 : tensor<1x5x14x10xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


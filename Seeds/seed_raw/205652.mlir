module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.376000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.372100e+02> : tensor<8x8x3x5xf32>}> : () -> tensor<8x8x3x5xf32>
    %2 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 3 : i32} : (tensor<8x8x3x5xf32>) -> tensor<8x8x3x1xf32>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<8x8x3x1xf32>) -> tensor<8x8x3x1xf32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<8x8x3x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


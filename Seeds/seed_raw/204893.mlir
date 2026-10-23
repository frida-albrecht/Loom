module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<38> : tensor<3x8xi64>}> : () -> tensor<3x8xi64>
    %1 = "tosa.const"() <{values = dense<9.140000e+00> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reverse %0 {axis = 0 : i32} : (tensor<3x8xi64>) -> tensor<3x8xi64>
    %3 = tosa.tanh %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<3x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


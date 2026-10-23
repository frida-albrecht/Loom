module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<6x2xi64>}> : () -> tensor<6x2xi64>
    %1 = "tosa.const"() <{values = dense<4.350000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<[6, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %0, %2 : (tensor<6x2xi64>, !tosa.shape<4>) -> tensor<6x2x1x1xi64>
    %4 = tosa.concat %3, %3 {axis = 3 : i32} : (tensor<6x2x1x1xi64>, tensor<6x2x1x1xi64>) -> tensor<6x2x1x2xi64>
    %5 = tosa.floor %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<6x2x1x2xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


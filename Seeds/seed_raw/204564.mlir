module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<179> : tensor<4x1x2x8xi64>}> : () -> tensor<4x1x2x8xi64>
    %1 = "tosa.const"() <{values = dense<3.255000e+01> : tensor<4x9x4xf32>}> : () -> tensor<4x9x4xf32>
    %2 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<4x1x2x8xi64>) -> tensor<4x1x2x8xi64>
    %3 = tosa.log %1 : (tensor<4x9x4xf32>) -> tensor<4x9x4xf32>
    %cast = tensor.cast %2 : tensor<4x1x2x8xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %3 : tensor<4x9x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<157> : tensor<2x1xi32>}> : () -> tensor<2x1xi32>
    %1 = "tosa.const"() <{values = dense<199> : tensor<2x1xi32>}> : () -> tensor<2x1xi32>
    %2 = "tosa.const"() <{values = dense<6.700000e-01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %4 = tosa.abs %3 : (tensor<2x1xi32>) -> tensor<2x1xi32>
    %5 = tosa.floor %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_max %4 {axis = 1 : i32} : (tensor<2x1xi32>) -> tensor<2x1xi32>
    %7 = tosa.bitwise_or %6, %4 : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %8 = tosa.intdiv %7, %7 : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


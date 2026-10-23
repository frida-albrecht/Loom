module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.995000e+02> : tensor<3x1x4x8xf32>}> : () -> tensor<3x1x4x8xf32>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<3x1x4x8xf32>) -> tensor<3x1x4x8xf32>
    %2 = tosa.abs %1 : (tensor<3x1x4x8xf32>) -> tensor<3x1x4x8xf32>
    %3 = tosa.reduce_max %2 {axis = 2 : i32} : (tensor<3x1x4x8xf32>) -> tensor<3x1x1x8xf32>
    %cast = tensor.cast %3 : tensor<3x1x1x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


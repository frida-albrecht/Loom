module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.470000e+01> : tensor<1x8x4xf32>}> : () -> tensor<1x8x4xf32>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<1x8x4xf32>) -> tensor<1x8x1xf32>
    %cast = tensor.cast %1 : tensor<1x8x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


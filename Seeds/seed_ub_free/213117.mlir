module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.527200e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tosa.abs %0 : (tensor<5xf32>) -> tensor<5xf32>
    %2 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<1xf32>
    %3 = tosa.clamp %2 {max_val = 1.100000e+02 : f32, min_val = -5.000000e+01 : f32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


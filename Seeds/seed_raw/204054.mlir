module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<146> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<62> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-1.953200e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.sub %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = tosa.logical_left_shift %3, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


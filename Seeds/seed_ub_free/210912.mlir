module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<40> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<1.724500e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<14> : tensor<10x10x8xi32>}> : () -> tensor<10x10x8xi32>
    %3 = tosa.clamp %0 {max_val = 1 : i32, min_val = -38 : i32} : (tensor<i32>) -> tensor<i32>
    %4 = tosa.ceil %1 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<10x10x8xi32>) -> tensor<1x10x8xi32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %5 : tensor<1x10x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}


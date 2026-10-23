module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.159700e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.586400e+02> : tensor<4x10x10x6xf32>}> : () -> tensor<4x10x10x6xf32>
    %2 = tosa.ceil %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reverse %1 {axis = 1 : i32} : (tensor<4x10x10x6xf32>) -> tensor<4x10x10x6xf32>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<4x10x10x6xf32>) -> tensor<4x10x10x6xf32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<4x10x10x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


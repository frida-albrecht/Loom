module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<62> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %1 = "tosa.const"() <{values = dense<195> : tensor<3x55xi32>}> : () -> tensor<3x55xi32>
    %2 = "tosa.const"() <{values = dense<1.559200e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<3x2xi32>, tensor<3x55xi32>) -> tensor<3x57xi32>
    %4 = tosa.abs %3 : (tensor<3x57xi32>) -> tensor<3x57xi32>
    %5 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.abs %5 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<3x57xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


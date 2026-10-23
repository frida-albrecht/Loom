module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<104> : tensor<6x3xi32>}> : () -> tensor<6x3xi32>
    %1 = "tosa.const"() <{values = dense<1.769600e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<6x3xi32>) -> tensor<6x1xi32>
    %3 = tosa.tanh %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<6x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

